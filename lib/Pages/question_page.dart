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

  QuestionPage(
      this.question, this.player, this.amountOfQuestions, this.currentQuestion,
      {super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<Color> buttonColors; 
  late List<String> answers; 
  bool ignore = false; 

  @override
  void initState() {
    super.initState();
    
    answers = List.from(widget.question.incorrectAnswers)
      ..add(widget.question.correctAnswer)
      ..shuffle();

    
    buttonColors = List.filled(answers.length, Colors.grey[800]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)),
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
                text: TextSpan(
                    text: 'player turn:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18),
                    children: [
                      TextSpan(
                          text: "\n${widget.player.name}",
                          style: TextStyle(color: widget.player.color)),
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
          duration: 15,
          fillColor: Colors.black,
          ringColor: Colors.grey,
          isReverse: true,
          isReverseAnimation: false,
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
                              text:
                                  "${widget.currentQuestion.toString()}/${widget.amountOfQuestions.toString()}",
                              style: TextStyle(color: Colors.black))),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey))),
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
          child: questionSelector(),
        ),
      ]),
    );
  }

  void turnOffTouch() {
    setState(() {
      ignore = true;
    });
  }

  Widget questionSelector() {
    return Column(
      children: [
        for (int i = 0; i < answers.length; i += 2)
          Row(
            children: [
              Expanded(
                child: QuestionButton(
                  index: i,
                  text: answers[i],
                  isCorrect: widget.question.correctAnswer == answers[i],
                  player: widget.player,
                  height: 160,
                  color: buttonColors[i],
                  onAnswerSelected: (bool correct) {
                    handleAnswer(correct, i);
                  },
                ),
              ),
              if (i + 1 < answers.length)
                Expanded(
                  child: QuestionButton(
                    index: i + 1,
                    text: answers[i + 1],
                    isCorrect: widget.question.correctAnswer == answers[i + 1],
                    player: widget.player,
                    height: 160,
                    color: buttonColors[i + 1],
                    onAnswerSelected: (bool correct) {
                      handleAnswer(correct, i + 1);
                    },
                  ),
                ),
            ],
          ),
      ],
    );
  }

  void handleAnswer(bool correct, int index) {
    setState(() {
      turnOffTouch(); 

      if (correct) {
        buttonColors[index] = Colors.green;
      } else {
        buttonColors[index] = Colors.red;

        
        int correctIndex = answers.indexOf(widget.question.correctAnswer);
        if (correctIndex != -1) {
          buttonColors[correctIndex] = Colors.green;
        }
      }
    });

    
    Timer(Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pop(context);
      }
    });
  }
}

// ignore: must_be_immutable
class QuestionButton extends StatelessWidget {
  final int index;
  final String text;
  final bool isCorrect;
  final Player player;
  final double height;
  final Color color;
  final Function(bool) onAnswerSelected;

  const QuestionButton({
    required this.index,
    required this.text,
    required this.isCorrect,
    required this.player,
    required this.height,
    required this.color,
    required this.onAnswerSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          onAnswerSelected(isCorrect);
          if (isCorrect) {
            player.scorePoint();
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
                wrapWords: false,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}