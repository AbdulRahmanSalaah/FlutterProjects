import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home(this.changeScreen, {super.key});

  final void Function() changeScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: Colors.white.withOpacity(0.8),
          ),
          const SizedBox(height: 80), // to add space between the image and text
          Text(
            'Learn Flutter!',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          OutlinedButton.icon(
              onPressed: changeScreen,
              label: const Text('Start Quiz'),
              icon: const Icon(Icons.play_arrow),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              )),
        ],
      ),
    );
  }
}
