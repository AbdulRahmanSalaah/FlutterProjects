
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tic_tac_game/widgets/wrapper_container.dart';

import '../game_logic/check_result.dart';
import '../game_logic/minimax.dart';
import '../model/history_hive_model.dart';
import '../providers/game_providers.dart';
import '../storage/history_box.dart';
import '../theme/colors.dart';
import '../widgets/alert_dialog.dart';
import '../widgets/scoreboard.dart';

int playerXScore = 0;
int playerOScore = 0;

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({
    super.key,
    required this.playerXName,
    required this.playerOName,
    required this.isAgainstAI,
  });

  final String playerXName;
  final String playerOName;
  final bool isAgainstAI;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void dispose() {
    playerXScore = 0;
    playerOScore = 0;
    // ref.read(aiPlayingProvider.notifier).setAIPlaying(false);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> playerNames = {
      'X': widget.playerXName,
      'O': widget.playerOName,
    };
    final board = ref.watch(boardProvider);
    final currentPlayer = ref.watch(currentPlayerProvider);
    final winner = ref.watch(winnerProvider);
    final isAIPlaying = ref.watch(aiPlayingProvider);

    // Determine if the current orientation is landscape
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    void makeAIMove(boardNotifier, currentPlayerNotifier, winnerNotifier,
        BuildContext context) {
      ref.read(aiPlayingProvider.notifier).setAIPlaying(true);

      int bestScore = -1000;
      int bestMoveRow = -1;
      int bestMoveCol = -1;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j].isEmpty) {
            board[i][j] = 'O';
            int score = minimax(board, false);
            board[i][j] = '';

            if (score > bestScore) {
              bestScore = score;
              bestMoveRow = i;
              bestMoveCol = j;
            }
          }
        }
      }

      if (bestMoveRow != -1 && bestMoveCol != -1) {
        boardNotifier.updateBoard(bestMoveRow, bestMoveCol, 'O');
        if (checkWin(board, 'O')) {
          winnerNotifier.updateWinner('O');
          playerOScore++;
          showGameAlertDialog(
            "AI wins!",
            context,
            'O',
            () => resetGame('O', ref, isAgainstAI: widget.isAgainstAI),
          );

          HistoryBox.setHistory(
            HistoryModelHive(
              playerXName: widget.playerXName,
              playerOName: widget.playerOName,
              winner: 'O',
            ),
          );
        } else if (checkDraw(board)) {
          winnerNotifier.updateWinner('draw');
          showGameAlertDialog(
            "It's a draw!",
            context,
            'draw',
            () => resetGame('draw', ref, isAgainstAI: widget.isAgainstAI),
          );

          HistoryBox.setHistory(
            HistoryModelHive(
              playerXName: widget.playerXName,
              playerOName: widget.playerOName,
              winner: 'draw',
            ),
          );
        } else {
          currentPlayerNotifier.togglePlayer();
        }
      }

      ref.read(aiPlayingProvider.notifier).setAIPlaying(false);
    }

    void onCellTap(int row, int col) {
      if (isAIPlaying) return;
      final boardNotifier = ref.read(boardProvider.notifier);
      final currentPlayerNotifier = ref.read(currentPlayerProvider.notifier);
      final winnerNotifier = ref.read(winnerProvider.notifier);

      if (board[row][col].isEmpty && winner.isEmpty) {
        final currentPlayerValue = currentPlayer;
        boardNotifier.updateBoard(row, col, currentPlayerValue);

        if (checkWin(board, currentPlayerValue)) {
          winnerNotifier.updateWinner(currentPlayerValue);
          if (currentPlayerValue == 'X') {
            playerXScore++;
          } else {
            playerOScore++;
          }
          showGameAlertDialog(
            " ${playerNames[currentPlayerValue]} wins!",
            context,
            currentPlayerValue,
            () => resetGame(currentPlayerValue, ref,
                isAgainstAI: widget.isAgainstAI),
          );

          HistoryBox.setHistory(
            HistoryModelHive(
              playerXName: widget.playerXName,
              playerOName: widget.playerOName,
              winner: currentPlayerValue,
            ),
          );
        } else if (checkDraw(board)) {
          winnerNotifier.updateWinner('draw');
          showGameAlertDialog(
            "It's a draw!",
            context,
            "draw",
            () => resetGame('draw', ref, isAgainstAI: widget.isAgainstAI),
          );
          HistoryBox.setHistory(HistoryModelHive(
            playerXName: widget.playerXName,
            playerOName: widget.playerOName,
            winner: 'draw',
          ));
        } else {
          currentPlayerNotifier.togglePlayer();
          if (widget.isAgainstAI && currentPlayerValue == 'X') {
            ref.read(aiPlayingProvider.notifier).setAIPlaying(true);
            Future.delayed(const Duration(milliseconds: 700), () {
              makeAIMove(boardNotifier, currentPlayerNotifier, winnerNotifier,
                  context);
              ref.read(aiPlayingProvider.notifier).setAIPlaying(false);
            });
          }
        }
      }
    }

    return Scaffold(
      body: WrapperContainer(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - kToolbarHeight,
              child: isLandscape
                  ? Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ScoreBoard(
                                playerXName: widget.playerXName,
                                playerOName: widget.playerOName,
                                playerXScore: playerXScore,
                                playerOScore: playerOScore,
                                isTurn: currentPlayer == 'X',
                              ),
                              const SizedBox(height: 40),
                              buildResetButton(ref)
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 1,
                          child: buildGameBoard(board, onCellTap, isAIPlaying),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ScoreBoard(
                            playerXName: widget.playerXName,
                            playerOName: widget.playerOName,
                            playerXScore: playerXScore,
                            playerOScore: playerOScore,
                            isTurn: currentPlayer == 'X',
                          ),
                        ),
                        const SizedBox(height: 50),
                        Expanded(
                          flex: 6,
                          child: buildGameBoard(board, onCellTap, isAIPlaying),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              buildResetButton(ref),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGameBoard(
      List<List<String>> board, Function onCellTap, bool isAIPlaying) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: GridView.builder(
        padding: const EdgeInsets.all(5.0),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          final row = index ~/ 3;
          final col = index % 3;

          return GestureDetector(
            onTap: () {
              if (isAIPlaying == false) {
                onCellTap(row, col);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  board[row][col],
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.permanentMarker().fontFamily,
                    color: board[row][col] == 'X'
                        ? GameColors.kBlue
                        : GameColors.kPurple,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }

  Widget buildResetButton(WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () {
        final BoardNotifier boardNotifier = ref.read(boardProvider.notifier);
        boardNotifier.resetBoard();

        final WinnerNotifier winnerNotifier = ref.read(winnerProvider.notifier);
        winnerNotifier.updateWinner('');
      },
      icon: const Icon(Icons.refresh),
      label: const Text('Reset Game'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 22, 16, 16),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
