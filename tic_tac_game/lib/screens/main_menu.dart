import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_sizes.dart';
import '../theme/colors.dart';
import '../widgets/wrapper_container.dart';
import 'game_base_screen.dart';
import 'players_names_screen.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // wrapper_container is used to wrap the entire screen with a gradient background color
      body: WrapperContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tic Tac Toe',
                style: TextStyle(
                  color: GameColors.kWhitish,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.permanentMarker().fontFamily,
                ),
              ),

              // Add a gap of 4XL size using the gap4XL() function
              gap4XL(),
              MainMenuButtons(
                btnText: 'Single Player',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameBaseScreen(
                        playerOName: "AI",
                        playerXName: "You",
                        isAgainstAI: true,
                      ),
                    ),
                  );
                },
              ),

              // Add a gap of XL size using the gapXL() function
              gapXL(),

              MainMenuButtons(
                btnText: 'Multiplayer',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerNames(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// button widget for the main menu screen with a text and an onPressed function
class MainMenuButtons extends StatelessWidget {
  const MainMenuButtons(
      {super.key, required this.btnText, required this.onPressed});

  final String btnText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        // Set the width of the button to 80% of the screen width using MediaQuery widget to adapt to different screen sizes
        width: MediaQuery.of(context).size.width * 0.8,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: GameColors.kForeground,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            btnText,
            style: TextStyle(
              color: GameColors.kWhitish,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.permanentMarker().fontFamily,
            ),
          ),
        ),
      );
}
