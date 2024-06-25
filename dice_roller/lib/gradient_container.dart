import 'package:flutter/material.dart';
import 'dice_roller.dart';
// import 'styled_text.dart'; // Importing the custom widget

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override // Overriding the build method
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: startAlignment,
          end: endAlignment,
          colors: [
            Color.fromARGB(255, 25, 70, 111),
            Color.fromARGB(255, 60, 9, 61),
            Color.fromARGB(255, 82, 46, 140),
          ],
        ),
      ),
      child: const Center(
        // Center widget aligns its child widget to the center of the screen
        // child: StyledText('I hate programing'), // Custom widget
        child: DiceRoller(),
      ),
    );
  }
}
