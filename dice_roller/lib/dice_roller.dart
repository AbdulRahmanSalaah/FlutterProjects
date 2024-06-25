import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'dart:math';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int activeDice = random.nextInt(6) + 1;

  void rollDice() {
    int newDice;

    setState(() {
      newDice = random.nextInt(6) + 1;
      activeDice = newDice;
    });

    // activeDiceImage = 'images/dice-images/dice-2.png';
    dev.log(' changed to number $activeDice ');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.center,

      // Column will take the minimum height of its children
      mainAxisSize: MainAxisSize.min,

      children: [
        // Image widget
        Image.asset('images/dice-images/dice-$activeDice.png', width: 250.0),
        // TextButton(
        //     onPressed: () => log('clicked'),
        //     child: const Text('Roll the dice')),
        // OutlinedButton(
        //     onPressed: () => log('clicked'),
        //     child: const Text('Roll the dice')),

        // SizedBox is to add space between widgets
        const SizedBox(height: 100),

        // ElevatedButton widget with icon, label  and text
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 6, 0, 0),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: rollDice,
            // child: const Text('Roll the dice')),
            label: const Text('Roll the dice'),
            icon: const Icon(Icons.casino)),
      ],
    );
  }
}
