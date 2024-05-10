class QuestionOfTheDayModel {
  QuestionOfTheDayModel({
    required this.deckName,
    required this.index,
    required this.question,
  });

  factory QuestionOfTheDayModel.fromJson(Map<String, dynamic> json) {
    return QuestionOfTheDayModel(
      deckName: json['deckName'],
      index: json['index'],
      question: json['question'],
    );
  }

  final String deckName;
  final int index;
  final String question;
}
