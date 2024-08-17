import 'package:flutter/foundation.dart';
import '../../api_manager/dio client/dio_client.dart';
import '../../api_manager/dio client/endpoints.dart';
import '../../constants/constants_export.dart';
import '../../models/saved_question_model.dart';

enum FetchStatus { init, fetching, success, error }

class SavedQuestionsProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  List<SavedQuestionModel> _questionsaved = [];

  List<SavedQuestionModel> get savedQuestions => _questionsaved;

  FetchStatus _fetchStatus = FetchStatus.init;

  FetchStatus get fetchStatus => _fetchStatus;

  Future<void> getSavedQuestions({required String userId}) async {
    try {
      final Response response = await _client.post(Endpoints.SavedQuestions,
          data: {'userId': userId});
      if (response.data['success']) {
        final List responseData = response.data['FindSavedQuestion'];
        List<SavedQuestionModel> savedQuestionList = [];
        savedQuestionList = responseData.map((question) {
          return SavedQuestionModel.fromJson(question);
        }).toList();
        _questionsaved = savedQuestionList;
        _fetchStatus = FetchStatus.success;
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
}
