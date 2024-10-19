import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:template/mechanics/player.dart';
import 'package:template/mechanics/question_class.dart';

class QuestionPage extends StatelessWidget {
  final QuestionClass question;
  final Player player;
  const QuestionPage(this.question, this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Align(
          alignment: Alignment.topRight,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(text: 'player turn:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18), children: [
              TextSpan(text: "\n${player.name}", style: TextStyle(color: player.color)),
            ]),
          ),
        ),
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
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
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
        questionSelector(),
      ]),
    );
  }

  Widget questionSelector() {
    if (question.type == "multiple") {
      List answers = question.incorrectAnswers;
      answers.add(question.correctAnswer);
      answers.shuffle();

      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child:
                      QuestionButtton(answers[0], question.correctAnswer == answers[0] ? true : false, player, 160, Color.fromARGB(255, 43, 19, 46))),
              Expanded(
                  child:
                      QuestionButtton(answers[1], question.correctAnswer == answers[1] ? true : false, player, 160, Color.fromARGB(255, 35, 46, 19))),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child:
                      QuestionButtton(answers[2], question.correctAnswer == answers[2] ? true : false, player, 160, Color.fromARGB(255, 19, 29, 46))),
              Expanded(
                  child:
                      QuestionButtton(answers[3], question.correctAnswer == answers[3] ? true : false, player, 160, Color.fromARGB(255, 46, 19, 19))),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: QuestionButtton("True", question.correctAnswer == "True" ? true : false, player, 100, Color.fromARGB(255, 86, 153, 240))),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, bottom: 35),
            child: Text(
              "OR",
              style: TextStyle(fontSize: 32),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: QuestionButtton("False", question.correctAnswer == "False" ? true : false, player, 100, Color.fromARGB(255, 240, 86, 89))),
            ],
          ),
        ],
      );
    }
  }
}

class QuestionButtton extends StatelessWidget {
  final String text;
  final bool ifTrueAnswer;
  final Player player;
  final double height;
  final Color color;

  const QuestionButtton(this.text, this.ifTrueAnswer, this.player, this.height, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          if (ifTrueAnswer) {
            player.scorePoint();
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                text,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
