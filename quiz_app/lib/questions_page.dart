// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer_button.dart';
import 'data/questions.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage(this.onSelectedAnswer, {super.key});

  final void Function(String) onSelectedAnswer;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  var curIndex = 0;

  void moveToNextQuestion(String answer) {
    // log('User selected: $answer');


    // this is the function that will be called when the user selects an answer to a question 
    // widget is a reference to the QuestionsPage widget
    widget.onSelectedAnswer(answer);
    
    
    setState(() {
      curIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final curQuestion = questions[curIndex];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(
              'Question ${curIndex + 1} of ${questions.length}',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 10, 1, 10),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            curQuestion.question,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 30),

          // the '...' operator is used to spread the elements of the list into the parent list
          ...curQuestion.getShuffleAnswers().map(
            (e) {
              return Container(
                margin: const EdgeInsets.all(5),
                child: AnswerButton(
                  answerText: e,
                  onPressed: () => moveToNextQuestion(e),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
