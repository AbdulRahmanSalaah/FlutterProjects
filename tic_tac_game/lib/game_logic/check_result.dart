import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tic_tac_game/game_logic/minimax.dart';

import '../providers/game_providers.dart';

bool checkWin(List<List<String>> board, String player) {
  for (int i = 0; i < 3; i++) {
    if ((board[i][0] == player &&
            board[i][1] == player &&
            board[i][2] == player) ||
        (board[0][i] == player &&
            board[1][i] == player &&
            board[2][i] == player)) {
      return true;
    }
  }
  if ((board[0][0] == player &&
          board[1][1] == player &&
          board[2][2] == player) ||
      (board[0][2] == player &&
          board[1][1] == player &&
          board[2][0] == player)) {
    return true;
  }
  return false;
}

bool checkDraw(List<List<String>> board) =>
    board.every((row) => row.every((cell) => cell.isNotEmpty));

void resetGame (
  String currentPlayerValue,
  WidgetRef ref, {
  bool isAgainstAI = false,
}) {
  final boardNotifier = ref.read(boardProvider.notifier);
  final winnerNotifier = ref.read(winnerProvider.notifier);

  boardNotifier.resetBoard();

  // Determine the new starting player
  if (isAgainstAI) {
    if (winnerNotifier.winner == 'draw') {
      final newCurrentPlayer = ['X', 'O'][Random().nextInt(2)];

      // If playing against another player, randomly select the starting player
      ref.read(currentPlayerProvider.notifier).updatePlayer(newCurrentPlayer);

      if (newCurrentPlayer == 'O') {
        // ref.read(aiPlayingProvider.notifier).setAIPlaying(true);
        ref.read(aiPlayingProvider.notifier).setAIPlaying(true);

        Future.delayed(
          const Duration(milliseconds: 300),
          () {
            makeAIMove(ref, 'O');
          },
        );
      }
    } else {
      // If playing against AI, player always starts first
      ref.read(currentPlayerProvider.notifier).updatePlayer('X');

      // AI starts playing after player
      ref.read(aiPlayingProvider.notifier).setAIPlaying(false);
    }
  } else {
    final newCurrentPlayer = ['X', 'O'][Random().nextInt(2)];

    // If playing against another player, randomly select the starting player
    ref.read(currentPlayerProvider.notifier).updatePlayer(newCurrentPlayer);
  }

  winnerNotifier.updateWinner('');
}

void makeAIMove(WidgetRef ref, String aiPlayer) {
  final boardNotifier = ref.read(boardProvider.notifier);
  final currentPlayerNotifier = ref.read(currentPlayerProvider.notifier);
  final winnerNotifier = ref.read(winnerProvider.notifier);

  final board = boardNotifier.board;
  int bestScore = -1000;
  int bestMoveRow = -1;
  int bestMoveCol = -1;

  // Use the minimax algorithm to determine the best move for AI
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j].isEmpty) {
        board[i][j] = aiPlayer;
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
    boardNotifier.updateBoard(bestMoveRow, bestMoveCol, aiPlayer);
    if (checkWin(board, aiPlayer)) {
      winnerNotifier.updateWinner(aiPlayer);
    } else if (checkDraw(board)) {
      winnerNotifier.updateWinner('draw');
    } else {
      currentPlayerNotifier.togglePlayer();
      ref.read(aiPlayingProvider.notifier).setAIPlaying(false);
    }
  }
}
