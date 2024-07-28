import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/user_image.dart';

final firebase = FirebaseAuth.instance;

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var enteredEmail = '';
  var enteredName = '';
  var enteredPassword = '';

  File? selectedImage;

  bool isUploading = false;

  void submitForm() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || (!isLogin && selectedImage == null)) {
      return; // Stop if form is invalid
    }

    // Save form fields
    formKey.currentState!.save();

    // Show a loading indicator

    try {
      setState(() {
        isUploading = true;
      });
      if (isLogin) {
        // Attempt to sign in
        await firebase.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
      } else {
        // Attempt to sign up
        final user = await firebase.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );

        // Upload the user image if it exists
        if (selectedImage != null) {
          // Upload the image to Firebase Storage
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child('${user.user!.uid}.jpg');

          // Put the image file in the reference location in Firebase Storage
          await ref.putFile(selectedImage!);
          //  Get the image URL
          final imageUrl = await ref.getDownloadURL();

          // Save the user data to Firestore database after successful signup and image upload
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.user!.uid)
              .set({
            'name': enteredName,
            'email': enteredEmail,
            'image_url': imageUrl,
          });

          log(imageUrl);
        }
      }

      // Navigate to the next screen after successful login/signup
      // Navigator.of(context).pushReplacementNamed('/chat');
    } on FirebaseAuthException catch (e) {
      // Clear any existing snack bars
      ScaffoldMessenger.of(context).clearSnackBars();

      // Show the error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(getFriendlyErrorMessage(e)),
          duration: const Duration(seconds: 3),
        ),
      );

      setState(() {
        isUploading = false;
      });
    }
  }

// Function to get a user-friendly error message
  String getFriendlyErrorMessage(FirebaseAuthException e) {
    log(e.code);
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-not-found':
        return 'No user found with this email. Please sign up.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'This email is already registered. Please login.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'invalid-credential':
        return 'user-not-found. Please sign up.';
      default:
        return 'An unexpected error occurred. Please try again later.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 40,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  width: 200,
                  child: Image.asset('images/chat.png'),
                ),
                Card(
                  margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              if (!isLogin)
                                UserImage(
                                  onImagePicked: (File pickedImage) {
                                    selectedImage = pickedImage;
                                  },
                                ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                onSaved: (value) {
                                  enteredEmail = value!;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                              ),
                              if (!isLogin)
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                  ),
                                  onSaved: (value) {
                                    enteredName = value!;
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 4) {
                                      return 'Please enter a valid name.';
                                    }
                                    return null;
                                  },
                                ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                ),
                                obscureText: true,
                                onSaved: (value) {
                                  enteredPassword = value!;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 8) {
                                    return 'Please enter a valid password.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              if (isUploading)
                                const CircularProgressIndicator(),
                              if (!isUploading)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  onPressed: submitForm,
                                  child: Text(isLogin ? 'Login' : 'Signup'),
                                ),
                              if (!isUploading)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text(isLogin
                                      ? 'Create new account'
                                      : 'I already have an account'),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
