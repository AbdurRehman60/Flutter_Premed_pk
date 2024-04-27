import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class QuestionModel {
  final String questionText;
  final String? questionImage;
  final List options;
  final bool published;
  QuestionModel({
    required this.questionText,
    required this.questionImage,
    required this.options,
    required this.published,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> jsonResponse) {
    return QuestionModel(
      questionText: jsonResponse['ExplanationText'],
      questionImage: jsonResponse['QuestionImage'],
      options: jsonResponse['Options'],
      published: jsonResponse['Published'],
    );
  }
}
