import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import '../constants/constants_export.dart';
import '../models/question_model.dart';

class RecQuestionProvider extends ChangeNotifier {
  factory RecQuestionProvider() => _instance;

  RecQuestionProvider._internal();
  static final RecQuestionProvider _instance = RecQuestionProvider._internal();
  final DioClient _client = DioClient();

  final Map<String, List<QuestionModel>> _questionsMap = {};
  final Map<String, int> _currentPageMap = {};

  List<QuestionModel>? getQuestions(String deckName) => _questionsMap[deckName];

  int getCurrentPage(String deckName) => _currentPageMap[deckName] ?? 1;

  void clearQuestions(String deckName) {
    _questionsMap[deckName] = [];
    _currentPageMap[deckName] = 1;
    notifyListeners();
  }

  Future<void> fetchQuestions(String deckName, int page) async {
    try {
      // Clear previous questions before fetching new ones
      clearQuestions(deckName);

      final response = await _client.post(
        Endpoints.questions(page),
        data: {'DeckName': deckName},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('questions') && responseData['questions'] is List) {
          final List<dynamic> questionsJson = responseData['questions'];

          _questionsMap[deckName] = [];

          for (var json in questionsJson) {
            if (json != null) {
              try {
                final question = QuestionModel.fromJson(json);
                _questionsMap[deckName]?.add(question);
              } catch (e) {
                print('Error parsing question JSON: $e');
              }
            } else {
              print('Skipping null question object in response');
            }
          }
          _currentPageMap[deckName] = page;
          notifyListeners();
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

  void reset() {
    _questionsMap.clear();
    _currentPageMap.clear();
    notifyListeners();
  }
}
