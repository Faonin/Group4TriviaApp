import 'dart:convert';

class QuestionClass {
  final String question;
  final String type;
  final String category;
  final String correctAnswer;
  final List incorrectAnswers;

  QuestionClass(this.question, this.type, this.category, this.correctAnswer, this.incorrectAnswers);

  factory QuestionClass.fromJson(Map<String, dynamic> json) {
    List incorrect = [];
    json["incorrect_answers"].forEach((i) => incorrect.add(utf8.decode(base64Decode(i))));
    return QuestionClass(utf8.decode(base64Decode(json["question"])), utf8.decode(base64Decode(json["type"])),
        utf8.decode(base64Decode(json["category"])), utf8.decode(base64Decode(json["correct_answer"])), incorrect);
  }

  Map<String, dynamic> fromJson() {
    return {"id": category, "title": question, "done": type};
  }
}
