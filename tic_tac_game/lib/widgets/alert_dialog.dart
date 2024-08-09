import 'package:flutter/material.dart';
import 'button_widget.dart';

void showGameAlertDialog(
    String message, BuildContext context, String winner, Function resetGame) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          // Prevent the dialog from closing on back button press
          return Future.value(false);
        },
        child: AlertDialog(
          backgroundColor: const Color.fromARGB(170, 60, 78, 92),
          elevation: 0,
          title: const Text(
            "Game Over",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          actions: [
            ButtonWidget(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              winner: winner,
              text: 'Play Again',
            ),
          ],
        ),
      );
    },
  );
}
