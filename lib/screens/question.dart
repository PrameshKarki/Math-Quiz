import 'package:flutter/material.dart';
import 'package:math_quiz/constants/questions.dart';
import 'package:math_quiz/screens/home.dart';

class QuestionScreen extends StatefulWidget {
  static const routeName = "/question";
  QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userInput = TextEditingController();
  int questionNumber = 0;

  void _buttonOnPressedHandler(BuildContext context) {
    if (userInput.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Invalid input'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    ;

    questions[questionNumber]["userAnswer"] = userInput.text;
    userInput.clear();
    Navigator.of(context).pushNamed(QuestionScreen.routeName, arguments: {
      "questionNumber": questionNumber + 1,
      "questions": questions
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (args != null) {
      setState(() {
        questionNumber = args["questionNumber"];
      });
    }

    if (questionNumber >= questions.length) {
      final totalCorrectAnswer = args["questions"]
          .where((question) =>
              question["answer"].toString() ==
              question["userAnswer"].toString())
          .length;
      final outputPercentage =
          ((totalCorrectAnswer / questions.length) * 100).round();

      return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              "Your score is ${totalCorrectAnswer}/${questions.length}= ${outputPercentage} %",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ListView.builder(
                itemCount: args["questions"].length ?? 0,
                shrinkWrap: true,
                itemBuilder: ((context, index) => Card(
                      child: ListTile(
                        title: Text(
                          args["questions"][index]["question"],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                            "Correct Answer: ${args["questions"][index]["answer"]}"),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(children: [
                            Text(
                              args["questions"][index]["userAnswer"],
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            args["questions"][index]["userAnswer"].toString() ==
                                    args["questions"][index]["answer"]
                                        .toString()
                                ? const Icon(
                                    Icons.check,
                                    size: 35,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.clear,
                                    size: 35,
                                    color: Colors.red,
                                  )
                          ]),
                        ),
                      ),
                    ))),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(HomePage.routeName),
                child: const Text("Play Again"))
          ],
        ),
      );
    }
    final question = questions[questionNumber]["question"] as String;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$question = ?",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: userInput,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter your answer",
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () => _buttonOnPressedHandler(context),
                      child: const Text("Next"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
