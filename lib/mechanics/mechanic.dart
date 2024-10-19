import 'package:flutter/material.dart';
import 'package:template/Pages/select_category.dart';
import 'package:template/pages/question_page.dart';
import 'package:template/mechanics/question_class.dart';
import 'player.dart';
import "question_fetcher.dart";

class GameMechanics {
  final bool multiplayer;
  final int amoutOfQuestions;
  List<Player> players = [];
  List<QuestionClass> questions = [];
  int selectedCategory = 0;

  GameMechanics(this.multiplayer, this.amoutOfQuestions) {
    if (!multiplayer) {
      players = [Player("Player 1", Colors.red)];
    }
  }

  addPlayers(List<Player> users) {
    players = users;
  }

  selectCategory(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCategory()));
  }

  start(BuildContext context) async {
    questions = await QuestionFetcher.getQuestions(amoutOfQuestions, selectedCategory);
    if (context.mounted) {
      for (var question in questions) {
        for (var player in players) {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(question, player)));
        }
      }
    }
    print(players[0].currentScore());
  }
}
