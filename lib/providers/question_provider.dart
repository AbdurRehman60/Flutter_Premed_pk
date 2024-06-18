import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';

class QuestionProvider extends ChangeNotifier {
  factory QuestionProvider() => _instance;

  QuestionProvider._internal();
  static final QuestionProvider _instance = QuestionProvider._internal();
  final DioClient _client = DioClient();

  void notify() {
    notifyListeners();
  }

  List<QuestionModel>? _questions;
  List<QuestionModel>? get questions => _questions;

  String _deckName = '';
  String get deckName => _deckName;
  set deckName(String value) {
    _deckName = value;
    notify();
  }



  void clearQuestions() {
    _questions = [];
    notify();
  }

  Future<void> fetchQuestions(String deckName, int page) async {
    try {
      final response = await _client.post(
        Endpoints.questions(page),
        data: {'DeckName': deckName},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('questions') && responseData['questions'] is List) {
          final List<dynamic> questionsJson = responseData['questions'];

          if (_questions == null) {
            _questions = [];
          }

          for (var json in questionsJson) {
            if (json != null) {
              try {
                final question = QuestionModel.fromJson(json);
                _questions?.add(question);
              } catch (e) {
                print('Error parsing question JSON: $e');
              }
            } else {
              print('Skipping null question object in response');
            }
          }
          notify();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }
}
