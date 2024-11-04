import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/mechanics/leaderboard_provider.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Text(
            "${index + 1}: ${context.watch<LeaderboardProvider>().leaderboardList[index].name}, Score: ${context.watch<LeaderboardProvider>().leaderboardList[index].score}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: context.watch<LeaderboardProvider>().leaderboardList[index].color),
          );
        },
        itemCount: context.watch<LeaderboardProvider>().leaderboardList.length,
      ),
    );
  }
}
