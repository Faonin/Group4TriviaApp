import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/mechanics/player.dart';

class LeaderboardProvider extends ChangeNotifier {
  List<String> _leaderboardList = [];

  List<Player> get leaderboardList => convertToPlayerList(_leaderboardList);

  updateLeaderboard() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getStringList("leaderboardList") == null) {
      await prefs.setStringList("leaderboardList", _leaderboardList);
    } else {
      _leaderboardList = prefs.getStringList("leaderboardList")!;
    }
    notifyListeners();
  }

  addToLeaderboard(Player newMember) async {
    var prefs = await SharedPreferences.getInstance();
    List<Player> playerList = convertToPlayerList(prefs.getStringList("leaderboardList")!);
    int compareToNumber = playerList.isEmpty ? -1 : playerList[playerList.length - 1].score;

    if (newMember.score > compareToNumber) {
      playerList.add(newMember);
      if (playerList.length > 10) {
        playerList.sort((b, a) => a.score.compareTo(b.score));
        _leaderboardList.removeLast();
      }
      List<String> newLeaderBoardList = [];
      for (var i = 0; i < playerList.length; i++) {
        newLeaderBoardList.add("${playerList[i].score}\n${playerList[i].name}\n${colorToHex(playerList[i].color)}");
      }
      await prefs.setStringList("leaderboardList", newLeaderBoardList);
      notifyListeners();
    }
  }

  List<Player> convertToPlayerList(List<String> listToConvert) {
    List<Player> newList = [];
    for (var i = 0; i < listToConvert.length; i++) {
      var splitPlayer = listToConvert[i].split("\n");
      Player convertedName = Player(splitPlayer[1], colorFromHex(listToConvert[i].split("\n")[2]) ?? Colors.black);
      convertedName.setScore(int.parse(splitPlayer[0]));
      newList.add(convertedName);
    }

    return newList;
  }
}
