import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:template/mechanics/player.dart';
import 'package:template/mechanics/question_class.dart';

// ignore: must_be_immutable
class QuestionPage extends StatefulWidget {
  final QuestionClass question;
  final Player player;
  final int amountOfQuestions;
  final int currentQuestion;

  QuestionPage(this.question, this.player, this.amountOfQuestions, this.currentQuestion, {super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late Widget selectedQuestions;
  late bool ignore = false;

  @override
  void initState() {
    super.initState();
    selectedQuestions = questionSelector();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: widget.question.category,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(text: 'player turn:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18), children: [
                  TextSpan(text: "\n${widget.player.name}", style: TextStyle(color: widget.player.color)),
                ]),
              ),
            ),
          ],
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        CircularCountDownTimer(
          width: 75,
          height: 75,
          duration: 10,
          fillColor: Colors.black,
          ringColor: Colors.grey,
          isReverse: true,
          isReverseAnimation: true,
          onComplete: () {
            Navigator.pop(context);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                          text: TextSpan(
                              text: "${widget.currentQuestion.toString()}/${widget.amountOfQuestions.toString()}",
                              style: TextStyle(color: Colors.black))),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: AutoSizeText(
                          widget.question.question,
                          maxFontSize: 100,
                          maxLines: 5,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        IgnorePointer(
          ignoring: ignore,
          child: selectedQuestions,
        ),
      ]),
    );
  }

  void turnOffTouch() {
    ignore = true;
  }

  Widget questionSelector() {
    if (widget.question.type == "multiple") {
      List answers = List.from(widget.question.incorrectAnswers);
      answers.add(widget.question.correctAnswer);
      answers.shuffle();
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Listener(
                onPointerDown: (details) {
                  setState(() {
                    turnOffTouch();
                  });
                },
                child: QuestionButtton(
                    answers[0], widget.question.correctAnswer == answers[0] ? true : false, widget.player, 160, Color.fromARGB(255, 43, 19, 46)),
              )),
              Expanded(
                  child: Listener(
                onPointerDown: (details) {
                  setState(() {
                    turnOffTouch();
                  });
                },
                child: QuestionButtton(
                    answers[1], widget.question.correctAnswer == answers[1] ? true : false, widget.player, 160, Color.fromARGB(255, 35, 46, 19)),
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Listener(
                onPointerDown: (details) {
                  setState(() {
                    turnOffTouch();
                  });
                },
                child: QuestionButtton(
                    answers[2], widget.question.correctAnswer == answers[2] ? true : false, widget.player, 160, Color.fromARGB(255, 19, 29, 46)),
              )),
              Expanded(
                  child: Listener(
                onPointerDown: (details) {
                  setState(() {
                    turnOffTouch();
                  });
                },
                child: QuestionButtton(
                    answers[3], widget.question.correctAnswer == answers[3] ? true : false, widget.player, 160, Color.fromARGB(255, 46, 19, 19)),
              )),
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
                  child: Listener(
                onPointerDown: (details) {
                  setState(() {
                    turnOffTouch();
                  });
                },
                child: QuestionButtton(
                    "True", widget.question.correctAnswer == "True" ? true : false, widget.player, 100, Color.fromARGB(255, 86, 153, 240)),
              )),
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
                  child: Listener(
                onPointerDown: (details) {
                  setState(() {
                    turnOffTouch();
                  });
                },
                child: QuestionButtton(
                    "False", widget.question.correctAnswer == "False" ? true : false, widget.player, 100, Color.fromARGB(255, 240, 86, 89)),
              )),
            ],
          ),
        ],
      );
    }
  }
}

// ignore: must_be_immutable
class QuestionButtton extends StatefulWidget {
  final String text;
  final bool ifTrueAnswer;
  final Player player;
  final double height;
  late Color color;

  QuestionButtton(this.text, this.ifTrueAnswer, this.player, this.height, this.color, {super.key});

  @override
  State<QuestionButtton> createState() => _QuestionButttonState();
}

class _QuestionButttonState extends State<QuestionButtton> {
  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          if (widget.ifTrueAnswer) {
            setState(() {
              widget.color = Colors.green;
            });
            widget.player.scorePoint();
          } else {
            setState(() {
              widget.color = Colors.red;
            });
          }
          Timer(Duration(seconds: 2), () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          });
        },
        child: Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                wrapWords: false,
                widget.text,
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
