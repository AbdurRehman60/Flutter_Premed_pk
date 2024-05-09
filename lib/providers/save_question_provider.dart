import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';

enum Status {
  init,
  fetching,
  success,
}

class SaveQuestionProvider extends ChangeNotifier {

  SaveQuestionProvider({required this.userId});
  final Dio dio = Dio();
  Status status = Status.init;
  String message = '';
  final String userId;
  List<Map<String, String>> savedQuestions = [];

  Future<void> saveQuestion(String questionId, String subject) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await dio.post(
        Endpoints.serverURL + Endpoints.handleSavedQuestion,
        data: {
          'userId': userId,
          'questionId': questionId,
          'subject': subject,
        },
      );

      if (response.statusCode == 200) {
        status = Status.success;
        message = 'Question saved successfully';

        savedQuestions.add({'questionId': questionId, 'subject': subject});
      } else {
        status = Status.init;
        message = 'Failed to save question';
      }
    } catch (error) {
      status = Status.init;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }

  Future<void> removeQuestion(String questionId, String subject) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await dio.post(
        Endpoints.serverURL + Endpoints.handleSavedQuestion,
        data: {
          'userId': userId,
          'questionId': questionId,
          'subject': subject,
          'remove': true,
        },
      );

      if (response.statusCode == 200) {
        status = Status.init;
        message = 'Question removed successfully';

        savedQuestions.removeWhere((savedQuestion) =>
        savedQuestion['questionId'] == questionId &&
            savedQuestion['subject'] == subject);
      } else {
        status = Status.init;
        message = 'Failed to remove question';
      }
    } catch (error) {
      status = Status.init;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }

  bool isQuestionSaved(String questionId, String subject) {
    return savedQuestions.any((savedQuestion) =>
    savedQuestion['questionId'] == questionId &&
        savedQuestion['subject'] == subject);
  }
}