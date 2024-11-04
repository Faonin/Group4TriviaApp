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
    String member = "${newMember.score}${newMember.name}${colorToHex(newMember.color)}";
    _leaderboardList.add(member);
    if (_leaderboardList.length > 10) {
      _leaderboardList.sort();
      _leaderboardList.removeLast();
    }
    await prefs.setStringList("leaderboardList", _leaderboardList);
    notifyListeners();
  }

  List<Player> convertToPlayerList(List<String> listToConvert) {
    List<Player> newList = [];
    for (var i = 0; i < listToConvert.length; i++) {
      Player convertedName = Player(listToConvert[i].substring(1, listToConvert[i].length - 8),
          colorFromHex(listToConvert[i].substring(listToConvert[i].length - 8, listToConvert[i].length)) ?? Colors.black);
      convertedName.setScore(int.parse(listToConvert[i].substring(0, 1)));
      newList.add(convertedName);
    }

    return newList;
  }
}
