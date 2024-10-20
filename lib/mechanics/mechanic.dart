import 'package:flutter/material.dart';
import 'package:template/Pages/change_user_screen.dart';
import 'package:template/Pages/loading_page.dart';
import 'package:template/Pages/score_page.dart';
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

  Future<String> selectCategory(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCategory())).then((number) {
      if (number != 0) {
        try {
          selectedCategory = number + 8;
        } catch (e) {
          selectedCategory = 0;
        }
      }
      if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingPage()));
    });
    return "";
  }

  start(BuildContext context) async {
    await selectCategory(context);
    questions = await QuestionFetcher.getQuestions(amoutOfQuestions, selectedCategory);
    if (context.mounted) Navigator.pop(context);

    for (var i = 0; i < questions.length; i++) {
      for (var player in players) {
        // ignore: use_build_context_synchronously
        if (multiplayer & context.mounted) await Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeUserScreen(player)));
        if (context.mounted) {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(questions[i], player, questions.length, i + 1)));
        }
      }
    }
    if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (context) => ScorePage(players)));
  }
}
