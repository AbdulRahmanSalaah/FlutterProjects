import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/game_providers.dart';
import '../theme/app_sizes.dart';
import '../theme/colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/wrapper_container.dart';
import 'game_base_screen.dart';

class PlayerNames extends HookConsumerWidget {
  const PlayerNames({super.key});

  Widget buildTextField(String hintText, IconData icon, bool isX,
      ValueSetter<String> onChanged, TextEditingController controller) {
    return TextField(
      cursorColor: isX ? GameColors.kWhitish : GameColors.kPurple,
      style: TextStyle(
        color: GameColors.kWhitish,
        fontFamily: GoogleFonts.permanentMarker().fontFamily,
      ),
      controller: controller,
      onChanged: onChanged,
      maxLength: 20,
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadiusM(),
        ),
        fillColor: GameColors.kForeground,
        hintText: hintText,
        hintStyle: const TextStyle(color: GameColors.kBackground),
        prefixIcon: Icon(
          icon,
          color: isX ? GameColors.kBlue : GameColors.kPurple,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create two TextEditingController instances to control the text fields
    final playerXController = useTextEditingController();
    final playerOController = useTextEditingController();

    // Create a ValueNotifier instance to check if the button should be enabled or not
    // valueNotifier is a special type of listener that listens to changes in the value and rebuilds the widget
    final isBtnEnabled = useValueNotifier(false);

    // Create a function to check if the text fields are empty
    void checkFields() {
      // Check if the text fields are not empty and set the ValueNotifier value
      // to true if they are not empty
      isBtnEnabled.value = playerXController.text.isNotEmpty &&
          playerOController.text.isNotEmpty;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GameColors.kGradient1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: GameColors.kWhitish,
          ),
        ),
      ),
      body: WrapperContainer(
        child: SingleChildScrollView(
          child: SizedBox(
            // Set the height of the container to the screen height
            height: MediaQuery.of(context).size.height,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Enter Players Names',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.permanentMarker().fontFamily,
                    ),
                  ),
                ),
                gapXL(),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      buildTextField('Player X', Icons.close, true, (value) {
                        checkFields();
                      }, playerXController),
                      gapL(),
                      buildTextField('Player O', Icons.circle_outlined, false,
                          (value) {
                        checkFields();
                      }, playerOController),
                      gap2XL(),
                      SizedBox(
                        width: double.infinity,
                        child: HookBuilder(builder: (context) {
                          // Check if the button should be enabled or not using the ValueNotifier
                          final isEnabled = useValueListenable(isBtnEnabled);
                          return ButtonWidget(
                            isEnabled: isEnabled,
                            onPressed: () {
                              final BoardNotifier boardNotifier =
                                  ref.read(boardProvider.notifier);
                              boardNotifier.resetBoard();

                              final WinnerNotifier winnerNotifier =
                                  ref.read(winnerProvider.notifier);
                              winnerNotifier.updateWinner('');

                              FocusScope.of(context).unfocus(
                                disposition:
                                    UnfocusDisposition.previouslyFocusedChild,
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GameBaseScreen(
                                    playerOName: playerOController.text
                                        .toLowerCase()
                                        .trim(),
                                    playerXName: playerXController.text
                                        .toLowerCase()
                                        .trim(),
                                    isAgainstAI: false,
                                  ),
                                ),
                              );
                            },
                            text: 'Start Game',
                            
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
