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
    final tagsList = json['QDetails']?[0]['Tags'] as List? ?? [];
    final List<String> tagNames = tagsList.map((tag) => tag['name'] as String).toList();


    final qDetailsList = json['QDetails'] as List? ?? [];
    final firstQDetail = qDetailsList.isNotEmpty ? qDetailsList[0] : {};



    final document = html_parser.parse(firstQDetail['QuestionText'] ?? '');
    final String parsedQuestion = html_parser.parse(document.body?.text ?? '').documentElement!.text;



    final String createdAt = firstQDetail['createdAt'] ?? '';
    final DateTime parsedDate = DateTime.parse(createdAt);
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
