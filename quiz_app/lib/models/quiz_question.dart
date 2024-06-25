class QuizQuestion {
  final String question;

  final List<String> answers;

  const QuizQuestion(this.question, this.answers);

  List<String> getShuffleAnswers() {
    final List<String> shuffledAnswers =List.of(answers); // make a copy of the answers list (to avoid modifying the original list
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}
