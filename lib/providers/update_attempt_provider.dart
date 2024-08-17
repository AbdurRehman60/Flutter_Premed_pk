import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import '../api_manager/dio client/dio_client.dart';
import '../constants/constants_export.dart';

enum Status { init, fetching, success, error }

class AttemptProvider extends ChangeNotifier {
  final DioClient _client = DioClient();
  Status status = Status.init;
  String message = '';

  final List<Map<String, dynamic>> _attemptsBody = [];
  Map<String, dynamic>? _attemptInfo;

  List<Map<String, dynamic>> get attemptsBody => _attemptsBody;
  Map<String, dynamic>? get attemptInfo => _attemptInfo;

  Future<void> updateAttempt({
    required String attemptId,
    required Map<String, dynamic> attemptData,
    required int totalTimeTaken,
  }) async {
    status = Status.fetching;
    notifyListeners();

    _attemptsBody.add(attemptData);

    try {
      final response = await _client.patch(
        Endpoints.updateAttempt(attemptId),
        data: {
          'attemptsBody': _attemptsBody,
          'totalTimeTaken': totalTimeTaken,
        },
      );

      if (response.statusCode == 200) {
        status = Status.success;
        message = 'Attempt updated successfully';
      } else {
        status = Status.error;
        message = 'Failed to update attempt';
      }
    } catch (error) {
      status = Status.error;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateResult({
    required String attemptId,
    required int attempted,
    required double avgTimeTaken,
    required String deckName,
    required int negativesDueToWrong,
    required int noOfNegativelyMarked,
    required int totalMarks,
    required int totalQuestions,
    required int totalTimeTaken,
  }) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await _client.patch(
        Endpoints.updateResult(attemptId),
        data: {
          'attempted': attempted,
          'avgTimeTaken': avgTimeTaken,
          'deckName': deckName,
          'negativesDueToWrong': negativesDueToWrong,
          'noOfNegativelyMarked': noOfNegativelyMarked,
          'totalMarks': totalMarks,
          'totalQuestions': totalQuestions,
          'totalTimeTaken': totalTimeTaken,
        },
      );

      if (response.statusCode == 200) {
        status = Status.success;
        message = 'Result updated successfully';
      } else {
        status = Status.error;
        message = 'Failed to update result';
      }
    } catch (error) {
      status = Status.error;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAttemptInfo(String attemptId) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await _client.get(Endpoints.getAttemptInfo(attemptId));

      if (response != null && response['success'] == true) {
        _attemptInfo = response['data']['resultMeta'];
        status = Status.success;
        message = 'Attempt info fetched successfully';
      } else {
        status = Status.error;
        message = 'Failed to fetch attempt info';
      }
    } catch (error) {
      status = Status.error;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }
}

