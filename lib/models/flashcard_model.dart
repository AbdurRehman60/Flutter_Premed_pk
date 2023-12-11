class FlashcardModel {

  FlashcardModel({
    required this.id,
    required this.userName,
    required this.questionID,
    required this.questionText,
    required this.correctOption,
    required this.correctOptionText,
    required this.explanationText,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: json['_id'],
      userName: json['UserName'],
      questionID: json['QuestionID'],
      questionText: json['QuestionText'],
      correctOption: json['CorrectOption'],
      correctOptionText: json['CorrectOptionText'],
      explanationText: json['ExplanationText'],
      tags: List<String>.from(json['Tags']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  final String id;
  final String userName;
  final String questionID;

  final String questionText;
  final String correctOption;
  final String correctOptionText;
  final String explanationText;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'questionID': questionID,
      'questionText': questionText,
      'correctOption': correctOption,
      'correctOptionText': correctOptionText,
      'explanationText': explanationText,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
