import 'package:flutter/foundation.dart';
import '../../constants/constants_export.dart';
import '../../models/saved_question_model.dart';
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';

enum FetchStatus { init, fetching, success, error }
class SavedQuestionsProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  List<SavedQuestionModel> _questionsaved = [];

  List<SavedQuestionModel> get savedQuestions => _questionsaved;

  FetchStatus _fetchStatus = FetchStatus.init;

  FetchStatus get fetchStatus => _fetchStatus;

  Future<void> getSavedQuestions({required String userId}) async {
    try {
      _fetchStatus = FetchStatus.fetching;
      notifyListeners();


      final Response response = await _client.post(Endpoints.SavedQuestions,
          data: {'userId': userId});

      if (response.data['success']) {
        final List responseData = response.data['FindSavedQuestion'];

        final List<SavedQuestionModel> savedQuestionList = responseData
            .where((question) {
          final qDetailsList = question['QDetails'] as List? ?? [];
          return qDetailsList.isNotEmpty && qDetailsList[0]['Published'] == true; // Check for Published field
        })
            .map((question) => SavedQuestionModel.fromJson(question))
            .toList();


        _questionsaved = savedQuestionList;
        _fetchStatus = FetchStatus.success;
      } else {
        _fetchStatus = FetchStatus.error;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _fetchStatus = FetchStatus.error;
    } finally {
      notifyListeners();
    }
  }

  bool isQuestionSaved(String questionId, String subject) {
    print('toSave questionId: $questionId');
    print('subject Saved: $subject');
    print('savedQuestionLength: ${savedQuestions.length}');
    return savedQuestions.any((savedQuestion) =>
    savedQuestion.id == questionId);
  }
}
// bool isQuestionSaved(String questionId, String subject) {
//   print('toSave questionId: $questionId');
//   print('subject Saved: $subject');
//   print('savedQuestionLength: ${savedQuestions.length}');
//   return savedQuestions.any((savedQuestion) =>
//   savedQuestion.id == questionId &&
//       savedQuestion.subject == subject);
// }