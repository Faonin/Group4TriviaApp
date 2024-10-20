import 'package:flutter/material.dart';
import 'package:template/mechanics/player.dart';

class ScorePage extends StatelessWidget {
  final List<Player> players;
  ScorePage(this.players, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "${players[index].name}: ${players[index].score}",
              style: TextStyle(fontSize: 32, color: players[index].color),
            ),
          );
        },
      ),
    );
  }
}
