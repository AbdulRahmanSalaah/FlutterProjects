import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:quiz_app/data/questions.dart';

import 'quiz_summary.dart';

class Result extends StatelessWidget {
  const Result(this.userAnswers, this.restartQuiz, {super.key});

  final void Function() restartQuiz;

  final List<String> userAnswers; //  this variable will hold the user answers

//  this function will return the summary data
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summaryData = [];
    for (var i = 0; i < userAnswers.length; i++) {
      summaryData.add({
        'question_index': i,
        'question_text': questions[i].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': userAnswers[i],
      });
    }
    return summaryData;
  }

  @override
  Widget build(BuildContext context) {
    int numOfCorrectAnswers = getSummaryData()
        .where((element) => element['user_answer'] == element['correct_answer'])
        .length;

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Quiz Summary',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Text(
              'You answered $numOfCorrectAnswers out of ${questions.length} questions correctly!',
              style: const TextStyle(
                color: Color.fromARGB(255, 240, 236, 241),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Display the summary data
            QuizSummary(getSummaryData()),

            // Restart Quiz Button
            TextButton.icon(
              onPressed: restartQuiz,
              label: const Text(
                'Restart Quiz',
                style: TextStyle(
                  color: Color.fromARGB(255, 214, 216, 219),
                ),
              ),
              icon: const Icon(Icons.refresh),
              style: TextButton.styleFrom(
                iconColor: const Color.fromARGB(255, 214, 216, 219),
              ),
            ),
          ],
        ));
  }
}
