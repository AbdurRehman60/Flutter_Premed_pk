import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';

enum Status {
  init,
  fetching,
  success,
}

class SaveQuestionProvider extends ChangeNotifier {
  SaveQuestionProvider();

  final Dio dio = Dio();
  Status status = Status.init;
  String message = '';
  List<Map<String, String>> savedQuestions = [];

  // Method to save a question
  Future<void> saveQuestion(String questionId, String subject, String userId) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await dio.post(
        Endpoints.serverURL + Endpoints.handleSavedQuestion,
        data: {
          'userId': userId, // Use the provided userId
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

  // Method to remove a question
  Future<void> removeQuestion(String questionId, String subject, String userId) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await dio.post(
        Endpoints.serverURL + Endpoints.handleSavedQuestion,
        data: {
          'userId': userId, // Use the provided userId
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

  // Method to check if a question is saved
  bool isQuestionSaved(String questionId, String subject) {
    return savedQuestions.any((savedQuestion) =>
    savedQuestion['questionId'] == questionId &&
        savedQuestion['subject'] == subject);
  }
}
