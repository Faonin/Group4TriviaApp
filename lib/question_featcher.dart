import 'package:http/http.dart';

String endpoint = "https://opentdb.com/api.php?";

/*
amount 1-50
Dont need to be specified and will get random:
category 9-32
difficulty easy/medium/hard
type boolean/multipule
*/

class Questionfeatcher {
  static getQuestions(int amount, [var category, String? difficulty, String? type]) async {
    category == null ? category = "" : category = '&category=$category';
    difficulty == null ? difficulty = "" : difficulty = '&difficulty=$difficulty';
    type == null ? type = "" : type = '&type=$type';

    var url = '${endpoint}amount=1$category$difficulty$type';
    var response = await get(Uri.parse(url));
    print(url);
    print(response.body);
  }
}
