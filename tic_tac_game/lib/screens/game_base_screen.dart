import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/game_providers.dart';
import '../theme/colors.dart';
import '../widgets/history_list.dart';
import 'game_screen.dart';

class GameBaseScreen extends HookConsumerWidget {
  const GameBaseScreen({
    super.key,
    required this.playerXName,
    required this.playerOName,
    required this.isAgainstAI,
  });

  final String playerXName;
  final String playerOName;
  final bool isAgainstAI;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void resetGameState() {
      final aiPlaying = ref.read(aiPlayingProvider);

      if (aiPlaying) {
        // Do not reset the game state if AI is playing
        return;
      }
      final BoardNotifier boardNotifier = ref.read(boardProvider.notifier);
      boardNotifier.resetBoard();

      final WinnerNotifier winnerNotifier = ref.read(winnerProvider.notifier);
      winnerNotifier.updateWinner('');

      final CurrentPlayerNotifier currentPlayerNotifier =
          ref.read(currentPlayerProvider.notifier);

      if (!isAgainstAI) {
        currentPlayerNotifier.updatePlayer('X');
      }
    }

    return PopScope(
      onPopInvoked: (isPopped) {
        // Check if the navigation action can proceed (e.g., user pressed back button)
        if (isPopped) {
          // Reset the game state when the back button is pressed
          resetGameState();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GameColors.kGradient1,
          leading: IconButton(
            onPressed: () {
              resetGameState();

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: GameColors.kWhitish,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                buildHistoryBottomSheet(context);
              },
              icon: const Icon(
                Icons.history_outlined,
                color: GameColors.kWhitish,
              ),
            ),
          ],
        ),
        body: GameScreen(
          playerXName: playerXName,
          playerOName: playerOName,
          isAgainstAI: isAgainstAI,
        ),
      ),
    );
  }
}

//  this method will build a bottom sheet that will show the game history when the history icon is clicked
void buildHistoryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: GameColors.kLighterForeground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      ),
    ),
    elevation: 0,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const SizedBox(
        height: 500,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: HistoryList(),
        ),
      );

      // button to clear the history
    },
  );
}
