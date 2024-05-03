import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class QuestionModel {
  final String questionText;
  final String? questionImage;
  final String explanationText;
  final List options;
  final bool published;
  QuestionModel({
    required this.questionText,
    required this.questionImage,
    required this.options,
    required this.published,
    required this.explanationText
  });

  factory QuestionModel.fromJson(Map<String, dynamic> jsonResponse) {
    return QuestionModel(
      questionText: jsonResponse['QuestionText'],
      explanationText: jsonResponse['ExplanationText'],
      questionImage: jsonResponse['QuestionImage'],
      options: jsonResponse['Options'],
      published: jsonResponse['Published'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'questionImage': questionImage,
      'explanationText': explanationText,
      'options': options,
      'published': published,
    };
  }

}
