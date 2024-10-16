import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:template/question_class.dart';

String endpoint = "https://opentdb.com/api.php?";

/*
amount 1-50
Dont need to be specified and will get random:
category 9-32
difficulty easy/medium/hard
type boolean/multipule
*/

class Questionfeatcher {
  static Future<List<QuestionClass>> getQuestions(int amount, [var category, String? difficulty, String? type]) async {
    category == null ? category = "" : category = '&category=$category';
    difficulty == null ? difficulty = "" : difficulty = '&difficulty=$difficulty';
    type == null ? type = "" : type = '&type=$type';

    var url = '${endpoint}amount=$amount$category$difficulty$type';
    http.Response response = await http.get(Uri.parse(url));
    String body = response.body;
    Map jsonResponse = jsonDecode(body);

    return (jsonResponse["results"] as List).map((json) => QuestionClass.fromJson(json)).toList();
  }
}
