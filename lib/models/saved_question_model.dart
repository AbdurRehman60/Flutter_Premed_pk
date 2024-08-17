import 'package:html/parser.dart' as html_parser;
import 'package:intl/intl.dart';

class SavedQuestionModel {
  SavedQuestionModel({
    required this.question,
    required this.subject,
    required this.tags,
    required this.createdAt,
  });

  factory SavedQuestionModel.fromJson(Map<String, dynamic> json) {
    final qDetailsList = json['QDetails'] as List? ?? [];

    // Extract tags only if QDetails is not empty
    final List<String> tagNames = qDetailsList.isNotEmpty
        ? (qDetailsList[0]['Tags'] as List? ?? []).map((tag) => tag['name'] as String).toList()
        : [];

    final firstQDetail = qDetailsList.isNotEmpty ? qDetailsList[0] : {};

    final document = html_parser.parse(firstQDetail['QuestionText'] ?? '');
    final String parsedQuestion = html_parser.parse(document.body?.text ?? '').documentElement?.text ?? '';

    final String createdAt = firstQDetail['createdAt'] ?? '';
    final DateTime parsedDate = DateTime.tryParse(createdAt) ?? DateTime.now(); // Fallback to current date if parsing fails
    final String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);

    return SavedQuestionModel(
      question: parsedQuestion,
      subject: json['subject'] ?? '',
      tags: tagNames,
      createdAt: formattedDate,
    );
  }

  final String question;
  final String subject;
  final List<String> tags;
  final String createdAt;
}
