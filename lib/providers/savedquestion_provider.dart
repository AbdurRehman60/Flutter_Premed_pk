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
      _fetchStatus = FetchStatus.fetching; // Set status to fetching
      notifyListeners(); // Notify listeners to update UI

      // Make the API call
      final Response response = await _client.post(Endpoints.SavedQuestions,
          data: {'userId': userId});

      if (response.data['success']) {
        final List responseData = response.data['FindSavedQuestion'];

        // Filter out unpublished questions and map the published ones to models
        final List<SavedQuestionModel> savedQuestionList = responseData
            .where((question) {
          final qDetailsList = question['QDetails'] as List? ?? [];
          return qDetailsList.isNotEmpty && qDetailsList[0]['Published'] == true; // Check for Published field
        })
            .map((question) => SavedQuestionModel.fromJson(question))
            .toList();

        // Update the provider state
        _questionsaved = savedQuestionList;
        _fetchStatus = FetchStatus.success; // Set status to success
      } else {
        _fetchStatus = FetchStatus.error; // Set status to error if the response is unsuccessful
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e); // Log the error in debug mode
      }
      _fetchStatus = FetchStatus.error; // Set status to error in case of exception
    } finally {
      notifyListeners(); // Notify listeners to update UI
    }
  }

  bool isQuestionSaved(String questionId, String subject) {
    print('toSave questionId: $questionId');
    print('subject Saved: $subject');
    print('savedQuestionLength: ${savedQuestions.length}');
    return savedQuestions.any((savedQuestion) =>
    savedQuestion.id == questionId &&
        savedQuestion.subject == subject);
  }
}
