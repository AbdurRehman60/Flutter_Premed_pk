import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class QuestionModel {
  final bool isMock, isTutorModeFree, timedTestMode;
  final int timedTestMinutes;
  final List Questions;
  QuestionModel(
      {required this.isMock,
      required this.isTutorModeFree,
      required this.timedTestMode,
      required this.timedTestMinutes,
      required this.Questions});

  factory QuestionModel.fromJson(json) {
    return QuestionModel(
        isTutorModeFree: json['isTutorModeFree'],
        isMock: json['isMock'],
        timedTestMode: json['timedTestMode'],
        timedTestMinutes: json['timedTestMinutes'],
        Questions: json['questions']);
  }
}
