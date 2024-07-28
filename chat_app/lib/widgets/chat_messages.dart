import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  _deleteMessage(BuildContext context, String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chat')
          .doc(messageId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message deleted.'),
          duration: Duration(milliseconds: 250),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete message: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user
    final authUser = FirebaseAuth.instance.currentUser;

    // Get the chat messages from the database and display them
    return StreamBuilder(
      // Get the chat messages from the database and order them by the time they were created in descending order
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),

      // Display the chat messages
      builder: (context, chatSnapshot) {
        // If the connection is still waiting, show a loading indicator
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // If an error occurred, show an error message
        if (chatSnapshot.hasError) {
          return const Center(
            child: Text('An error occurred!'),
          );
        }

        // If there are no messages, show a message
        if (chatSnapshot.data == null || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages yet!'),
          );
        }

        // Get the chat messages
        final chatDocs = chatSnapshot.data!.docs;

        // Display the chat messages
        return ListView.builder(
          // Reverse the order of the chat messages so that the latest message is at the bottom
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            // Get the chat message data
            final chatData = chatDocs[index].data();
            // Get the message ID
            final messageId = chatDocs[index].id;

            // Get the next chat message data if it exists
            final nextMessage =
                index < chatDocs.length - 1 ? chatDocs[index + 1].data() : null;

            // Get the user ID of the current chat message
            final messageUserId = chatData['userId'];
            // Get the user ID of the next chat message if it exists
            final nextMessageUserId =
                nextMessage != null ? nextMessage['userId'] : null;

            // Check if the next chat message is from the same user
            final bool nextUserIsSame = messageUserId == nextMessageUserId;

            // Display the chat message in the appropriate bubble based on the user who sent it
            // and whether the next message is from the same user or not
            // If the next message is from the same user, display the message in a bubble that is next to the previous message
            // If the next message is from a different user, display the message in a bubble that is the first in the sequence
            return GestureDetector(
              onLongPress: () {
                // Show a confirmation dialog when a long press is detected and the message was sent by the current user
                if (authUser.uid == messageUserId) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Delete Message'),
                      content: const Text(
                          'Are you sure you want to delete this message?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _deleteMessage(context, messageId);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: nextUserIsSame
                  ? MessageBubble.next(
                      message: chatData['text'],
                      // Display the user image and username only for the first message in the sequence
                      isMe: authUser!.uid == messageUserId,
                    )
                  : MessageBubble.first(
                      userImage: chatData['userImage'],
                      username: chatData['username'],
                      message: chatData['text'],
                      isMe: authUser!.uid == messageUserId,
                    ),
            );
          },
        );
      },
    );
  }
}
