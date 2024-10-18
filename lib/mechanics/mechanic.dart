import 'package:flutter/material.dart';
import 'package:template/pages/question_page.dart';
import 'package:template/question_class.dart';
import 'player.dart';
import "question_fetcher.dart";

class GameMechanics {
  final bool multiplayer;
  final int amoutOfQuestions;
  List<Player> players = [];
  List<QuestionClass> questions = [];

  GameMechanics(this.multiplayer, this.amoutOfQuestions) {
    if (!multiplayer) {
      players = [Player("Player")];
    }
  }

  start(BuildContext context) async {
    questions = await QuestionFetcher.getQuestions(amoutOfQuestions);
    if (context.mounted) {
      for (var question in questions) {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(question)));
      }
    }
  }

  next(BuildContext context) async {}
}
