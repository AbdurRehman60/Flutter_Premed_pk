import 'package:html/parser.dart' as html_parser;
import 'package:intl/intl.dart';

class SavedQuestionModel {
  SavedQuestionModel({
    required this.question,
    required this.subject,
    required this.tags,
    required this.explanationImage,
    required this.explanationText,
    required this.options,
    required this.createdAt,
    required this.category,
    required this.topic,
    required this.id,
    required this.qObjectId
  });

  factory SavedQuestionModel.fromJson(Map<String, dynamic> json) {
    final qDetailsList = json['QDetails'] as List? ?? [];

    // Assuming the first element contains the required details
    final firstQDetail = qDetailsList.isNotEmpty ? qDetailsList[0] : null;

    if (firstQDetail == null) {
      throw Exception('Invalid question details');
    }

    // Extract the question ID from QDetails
    final String id = firstQDetail['_id'] ?? '';

    final List<String> tagNames = (firstQDetail['Tags'] as List? ?? [])
        .map((tag) => tag['name'] as String)
        .toList();

    final document = html_parser.parse(firstQDetail['QuestionText'] ?? '');
    final String parsedQuestion =
        html_parser.parse(document.body?.text ?? '').documentElement?.text ?? '';

    final String createdAt = firstQDetail['createdAt'] ?? '';
    final DateTime parsedDate =
        DateTime.tryParse(createdAt) ?? DateTime.now(); // Fallback to current date if parsing fails
    final String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);

    final String explanationImage = firstQDetail['ExplanationImage'] ?? '';
    final String explanationText =
        html_parser.parse(firstQDetail['ExplanationText'] ?? '')
            .documentElement
            ?.text ?? '';

    final List<Map<String, dynamic>> optionsList =
    (firstQDetail['Options'] as List? ?? []).map((option) {
      return {
        'optionLetter': option['OptionLetter'] ?? '',
        'optionText':
        html_parser.parse(option['OptionText'] ?? '').documentElement?.text ?? '',
        'isCorrect': option['IsCorrect'] ?? false,
        'choiceExplanationText' : html_parser.parse(option['ExplanationText'] ?? '').documentElement?.text ?? '',
      };
    }).toList();

    final Map<String, dynamic>? meta =
    firstQDetail['meta'] as Map<String, dynamic>?;
    final String category = meta?['category'] ?? '';
    final String topic = meta?['topic'] ?? '';

    return SavedQuestionModel(
      qObjectId: json['_id'],
      id: id,
      question: parsedQuestion,
      subject: json['subject'] ?? '',
      tags: tagNames,
      explanationImage: explanationImage,
      explanationText: explanationText,
      options: optionsList,
      createdAt: formattedDate,
      category: category,
      topic: topic,
    );
  }

  final String question;
  final String subject;
  final List<String> tags;
  final String explanationImage;
  final String explanationText;
  final List<Map<String, dynamic>> options;
  final String createdAt;
  final String category;
  final String topic;
  final String id;
  final String qObjectId;
}





