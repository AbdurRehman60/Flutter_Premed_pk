import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/question_model.dart';
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';

class QuestionProvider extends ChangeNotifier {
  factory QuestionProvider() => _instance;

  QuestionProvider._internal();
  static final QuestionProvider _instance = QuestionProvider._internal();
  final DioClient _client = DioClient();


  final Map<int, QuestionModel> _questionsMap = {};
  List<QuestionModel> get questions => _questionsMap.values.toList();

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


  final Set<int> _loadedPages = {};
  Set<int> get loadedPages => _loadedPages;


  void clearQuestions() {
    _questionsMap.clear();
    _loadedPages.clear();
    notifyListeners();
  }


  bool isPageLoaded(int page) {
    return _loadedPages.contains(page);
  }


  Future<List<QuestionModel>> fetchQuestions(String deckName, int page) async {
    if (_loadedPages.contains(page)) {
      print('Page $page already loaded');
      return [];
    }

    try {
      _isLoading = true;
      notifyListeners();

      final response = await _client.post(
        Endpoints.questions(page),
        data: {'DeckName': deckName},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData.containsKey('questions') && responseData['questions'] is List) {
          final List<dynamic> questionsJson = responseData['questions'];
          final List<QuestionModel> fetchedQuestions = [];
          final int questionIndexOffset = (page - 1) * questionsJson.length;

          for (int i = 0; i < questionsJson.length; i++) {
            final json = questionsJson[i];
            if (json != null) {
              try {
                final question = QuestionModel.fromJson(json);
                _questionsMap[questionIndexOffset + i] = question;
                fetchedQuestions.add(question);
              } catch (e) {
                print('Error parsing question JSON: $e');
              }
            } else {
              print('Skipping null question object in response');
            }
          }

          _loadedPages.add(page);
          return fetchedQuestions;
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
