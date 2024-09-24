import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';

class QuestionProvider extends ChangeNotifier {
  factory QuestionProvider() => _instance;

  QuestionProvider._internal();
  static final QuestionProvider _instance = QuestionProvider._internal();
  final DioClient _client = DioClient();

  List<QuestionModel>? _questions = [];
  List<QuestionModel>? get questions => _questions;

  String _deckName = '';
  String get deckName => _deckName;
  set deckName(String value) {
    _deckName = value;
    clearQuestions();
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Set to track loaded pages
  Set<int> _loadedPages = {};
  Set<int> get loadedPages => _loadedPages;

  // Method to clear loaded questions and pages
  void clearQuestions() {
    _questions = [];
    _loadedPages.clear();
    notifyListeners();
  }

  // New method to check if a page is loaded
  bool isPageLoaded(int page) {
    return _loadedPages.contains(page);
  }

  // Fetch questions for a specific page
  Future<List<QuestionModel>> fetchQuestions(String deckName, int page) async {
    if (_loadedPages.contains(page)) {
      print('Page $page already loaded');
      return [];
    }

    try {
      _isLoading = true;
      notifyListeners(); // Notify listeners to show loading

      final response = await _client.post(
        Endpoints.questions(page),
        data: {'DeckName': deckName},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('questions') && responseData['questions'] is List) {
          final List<dynamic> questionsJson = responseData['questions'];
          List<QuestionModel> fetchedQuestions = [];
          for (final json in questionsJson) {
            if (json != null) {
              try {
                final question = QuestionModel.fromJson(json);
                _questions?.add(question);
                fetchedQuestions.add(question); // Collect fetched questions
              } catch (e) {
                print('Error parsing question JSON: $e');
              }
            } else {
              print('Skipping null question object in response');
            }
          }
          _loadedPages.add(page);
          return fetchedQuestions; // Return the list of fetched questions
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching questions: $e');
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

