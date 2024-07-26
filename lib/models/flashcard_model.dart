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
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    final questionDetails = json['QDetails'][0];
    final correctOption = questionDetails['Options']
        .firstWhere((option) => option['IsCorrect'] == true);

    return FlashcardModel(
      id: json['_id'],
      subject: json['subject'],
      questionText: questionDetails['QuestionText'],
      tags:
          List<String>.from(questionDetails['Tags'].map((tag) => tag['name'])),
      topic: questionDetails['meta']['topic'],
      type: questionDetails['meta']['type'],
      year: questionDetails['meta']['year'],
      entity: questionDetails['meta']['entity'],
      category: questionDetails['meta']['category'],
      explanationText: correctOption['ExplanationText'],
      optionText: correctOption['OptionText'],
    );
  }
  final String id;
  final String subject;
  final String questionText;
  final List<String> tags;
  final String topic;
  final String type;
  final int? year;
  final String entity;
  final String category;
  final String explanationText;
  final String optionText;
}
