import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:template/question_fetcher.dart';
import 'package:template/question_class.dart';

class QuestionPage extends StatelessWidget {
  final QuestionClass question;
  const QuestionPage(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text("count down"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey))),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: AutoSizeText(
                      question.question,
                      maxFontSize: 100,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: questionSelector1()),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: questionSelector2()),
      ]),
    );
  }

  List<Widget> questionSelector1() {
    if (question.type == "multiple") {
      return [
        Expanded(child: QuestionButtton(question.correctAnswer)),
        Expanded(child: QuestionButtton(question.incorrectAnswers[0])),
      ];
    } else {
      return [
        Expanded(child: QuestionButtton(question.correctAnswer)),
      ];
    }
  }

  List<Widget> questionSelector2() {
    if (question.type == "multiple") {
      return [
        Expanded(child: QuestionButtton(question.incorrectAnswers[1])),
        Expanded(child: QuestionButtton(question.incorrectAnswers[2])),
      ];
    } else {
      return [
        Expanded(child: QuestionButtton(question.incorrectAnswers[0])),
      ];
    }
  }
}

class QuestionButtton extends StatelessWidget {
  final String text;
  const QuestionButtton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () async {
          List<QuestionClass> questions = await QuestionFetcher.getQuestions(1);
          QuestionClass question = questions.first;
          if (context.mounted)
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionPage(question)));
        },
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 43, 19, 46),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
