import 'package:flutter/material.dart';
import 'package:math_quiz/screens/question.dart';

import '../constants/questions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Math Quiz'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Math Quiz',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, QuestionScreen.routeName,
                      arguments: {"questionNumber": 0, "questions": questions});
                },
                child: const Text('Play Now'),
              ),
            ],
          ),
        ));
  }
}
