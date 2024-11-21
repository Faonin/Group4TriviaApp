import 'package:flutter/material.dart';

class Player {
  final String name;
  final Color color;
  int score = 0;
  Player(this.name, this.color);

  scorePoint() {
    score += 1;
  }

  int currentScore() {
    return score;
  }

  setScore(int newScore) {
    score = newScore;
  }
}
