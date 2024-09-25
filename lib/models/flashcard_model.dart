class FlashcardModel {
  FlashcardModel({
    required this.id,
    required this.subject,
    required this.questionText,
    required this.tags,
    required this.topic,
    required this.type,
    required this.year,
    required this.entity,
    required this.category,
    required this.explanationText,
    required this.optionText,
    required this.questionId,
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json, String questionId) {
    final questionDetails = json['QDetails'][0];

    // Use orElse to handle cases where no option is found
    final correctOption = questionDetails['Options'].firstWhere(
          (option) => option['IsCorrect'] == true,
      orElse: () => null,
    );

    return FlashcardModel(
      id: json['_id'],
      subject: json['subject'],
      questionText: questionDetails['QuestionText'],
      tags: List<String>.from(questionDetails['Tags'].map((tag) => tag['name'])),
      topic: questionDetails['meta']['topic'],
      type: questionDetails['meta']['type'],
      year: questionDetails['meta']['year'],
      entity: questionDetails['meta']['entity'],
      category: questionDetails['meta']['category'],
      explanationText: correctOption != null ? correctOption['ExplanationText'] : null,
      optionText: correctOption != null ? correctOption['OptionText'] : '',
      questionId: questionId,
    );
  }

  final String id;
  final String? subject;
  final String questionText;
  final List<String> tags;
  final String topic;
  final String type;
  final int? year;
  final String entity;
  final String category;
  final String? explanationText;
  final String optionText;
  final String questionId;
}
