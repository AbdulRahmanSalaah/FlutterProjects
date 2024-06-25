import 'package:flutter/material.dart';

class QuizSummary extends StatelessWidget {
  const QuizSummary(this.summaryData, {super.key});

  // this variable will hold the summary data that take it from the Result class
  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    // im using sizebox as the parent widget to give the column a fixed height of 500 and to make it scrollable with SingleChildScrollView
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...summaryData.map((e) => Column(
                  children: [
                    Row(
                      children: [
                        // CircleAvatar widget to display the question index in a circle
                        CircleAvatar(
                          radius: 16,

                          // if the user answer is correct the background color will be blue, otherwise it will be red
                          backgroundColor:
                              e['user_answer'] == e['correct_answer']
                                  ? Colors.blueAccent
                                  : Colors.red[300],
                          child: Text(
                            ((e['question_index'] as int) + 1).toString(),
                          ),
                        ),

                        const SizedBox(width: 15),

                        // Expanded widget will take the remaining space of the row  to display the question text and the answers text in the same row
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 13.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const SizedBox(height: 10),
                                Text(
                                  e['question_text'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                Text(
                                  'Your Answer: ${e['user_answer']}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(195, 239, 243, 239),
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Correct Answer: ${e['correct_answer']}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(154, 9, 96, 226),
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
