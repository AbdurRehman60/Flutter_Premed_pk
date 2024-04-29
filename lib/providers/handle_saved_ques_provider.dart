import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';

enum Status {
  init,
  fetching,
  success,
}

class SaveQuestionProvider extends ChangeNotifier {
  final Dio dio = Dio();
  Status status = Status.init;
  String message = '';
  final String userId;
  List<Map<String, String>> savedQuestions = []; // List to store saved questions

  SaveQuestionProvider({required this.userId});

  Future<void> saveQuestion(String questionId, String subject) async {
    status = Status.fetching; // Set status to fetching before making the request
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
        status = Status.success; // Update status to success if request succeeds
        message = 'Question saved successfully';

        // Update savedQuestions list if the question is successfully saved
        savedQuestions.add({'questionId': questionId, 'subject': subject});
      } else {
        status = Status.init; // Reset status to init if request fails
        message = 'Failed to save question';
      }
    } catch (error) {
      status = Status.init; // Reset status to init in case of error
      message = 'Error: $error';
    } finally {
      notifyListeners(); // Notify listeners after updating status
    }
  }

  Future<void> removeQuestion(String questionId, String subject) async {
    status = Status.fetching; // Set status to fetching before making the request
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
        status = Status.init; // Update status to indicate question is not saved
        message = 'Question removed successfully';

        // Remove the question from savedQuestions list
        savedQuestions.removeWhere((savedQuestion) =>
        savedQuestion['questionId'] == questionId &&
            savedQuestion['subject'] == subject);
      } else {
        status = Status.init; // Reset status to init even if removal fails
        message = 'Failed to remove question';
      }
    } catch (error) {
      status = Status.init; // Reset status to init in case of error
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }

  bool isQuestionSaved(String questionId, String subject) {
    // Check if the question is already saved in the savedQuestions list
    return savedQuestions.any((savedQuestion) =>
    savedQuestion['questionId'] == questionId &&
        savedQuestion['subject'] == subject);
  }
}
