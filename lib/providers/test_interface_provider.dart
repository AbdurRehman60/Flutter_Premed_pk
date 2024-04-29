import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/endpoints.dart';
import 'package:premedpk_mobile_app/models/test_interface_model.dart';

class QuestionProvider extends ChangeNotifier {
  factory QuestionProvider() => _instance;

  QuestionProvider._internal();
  static final QuestionProvider _instance = QuestionProvider._internal();
  final DioClient _client = DioClient();

  void notify() {
    notifyListeners();
  }

  List<Question> _questions = [];
  List<Question> get questions => _questions;
  set questions(List<Question> value) {
    _questions = value;
    notify();
  }

  Future<void> fetchQuestions() async {
    try {
      final dynamic response = await _client.get(Endpoints.GetAllDeckQuestions);
      if (response is Map<String, dynamic>) {
        final List<dynamic>? questionsData = response['questions'];
        if (questionsData != null) {
          final List<Question> fetchedQuestions = questionsData.map((questionJson) {
            return Question.fromJson(questionJson);
          }).toList();
          questions = fetchedQuestions;
        } else {
          throw Exception('No questions data found in the response');
        }
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error fetching questions: $e');
      throw Exception('Failed to fetch questions. Please try again later.');
    }
  }
}
