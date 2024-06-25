import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/home_page.dart';
import 'package:quiz_app/questions_page.dart';

import 'result.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //   this is the variable that will hold the current screen
  Widget? switchScreen;

  List<String> userAnswers = [];

  void chooseAnswer(String answer) {
    userAnswers.add(answer);

    if (userAnswers.length == questions.length) {
     
      setState(() {
        switchScreen = Result(userAnswers, restartQuiz);
      });
    }
    log('User answers: $userAnswers'.toString());
  }

  @override
  void initState() {
    super.initState();
    switchScreen = Home(changeScreen);
  }

  void changeScreen() {
    setState(() {
      switchScreen = QuestionsPage(chooseAnswer);
    });
  }

  void restartQuiz() {
    setState(() {
      userAnswers = [];
      switchScreen = Home(changeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 27, 54, 76),
                Color.fromARGB(255, 111, 54, 121),
              ],
            ),
          ),
          child: switchScreen,
        ),
      ),
    );
  }
}
