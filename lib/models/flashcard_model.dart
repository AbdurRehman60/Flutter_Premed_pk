class FlashcardModel {
  final String id;
  final String userName;
  final String questionID;
  final String subject;
  final String questionText;
  final String correctOption;
  final String correctOptionText;
  final String explanationText;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  FlashcardModel({
    required this.id,
    required this.userName,
    required this.questionID,
    required this.subject,
    required this.questionText,
    required this.correctOption,
    required this.correctOptionText,
    required this.explanationText,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'questionID': questionID,
      'subject': subject,
      'questionText': questionText,
      'correctOption': correctOption,
      'correctOptionText': correctOptionText,
      'explanationText': explanationText,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: json['id'],
      userName: json['userName'],
      questionID: json['questionID'],
      subject: json['subject'],
      questionText: json['questionText'],
      correctOption: json['correctOption'],
      correctOptionText: json['correctOptionText'],
      explanationText: json['explanationText'],
      tags: List<String>.from(json['tags']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
