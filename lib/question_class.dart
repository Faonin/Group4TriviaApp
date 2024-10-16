class QuestionClass {
  final String question;
  final String type;
  final String category;
  final String correctAnswer;
  final List incorrectAnswers;

  QuestionClass(this.question, this.type, this.category, this.correctAnswer, this.incorrectAnswers);

  factory QuestionClass.fromJson(Map<String, dynamic> json) {
    return QuestionClass(json["question"], json["type"], json["category"], json["correct_answer"], json["incorrect_answers"]);
  }

  Map<String, dynamic> fromJson() {
    return {"id": category, "title": question, "done": type};
  }
}
