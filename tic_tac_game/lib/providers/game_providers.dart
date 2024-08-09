import 'package:hooks_riverpod/hooks_riverpod.dart';

class BoardNotifier extends StateNotifier<List<List<String>>> {
  BoardNotifier() : super(List.generate(3, (_) => List.filled(3, '')));

  // getter to get the current state of the board
  List<List<String>> get board => state;

  void resetBoard() {
    state = List.generate(3, (_) => List.filled(3, ''));
  }

  void updateBoard(int row, int col, String value) {
    state[row][col] = value;
  }
}

class CurrentPlayerNotifier extends StateNotifier<String> {
  CurrentPlayerNotifier() : super('X');

  // getter to get the current player
  void updatePlayer(String value) {
    state = value;
  }

  // Toggle the player after each move is made on the board
  // toggle means to switch the player from X to O or vice versa
  void togglePlayer() {
    state = state == 'X' ? 'O' : 'X';
  }
}

class WinnerNotifier extends StateNotifier<String> {
  WinnerNotifier() : super('');

// getter to get the winner of the game
  String get winner => state;



  void updateWinner(String value) {
    state = value;
  }
}

// New StateNotifier to manage the AI playing state
class AIPlayingNotifier extends StateNotifier<bool> {
  AIPlayingNotifier() : super(false);


  void setAIPlaying(bool value) {
    state = value;
  }
  
}

final boardProvider = StateNotifierProvider<BoardNotifier, List<List<String>>>(
    (ref) => BoardNotifier());
final currentPlayerProvider =
    StateNotifierProvider<CurrentPlayerNotifier, String>(
        (ref) => CurrentPlayerNotifier());
final winnerProvider =
    StateNotifierProvider<WinnerNotifier, String>((ref) => WinnerNotifier());

// New provider for AI playing state
final aiPlayingProvider = StateNotifierProvider<AIPlayingNotifier, bool>(
  (ref) => AIPlayingNotifier(),
);
