import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import '../api_manager/dio client/dio_client.dart';
import '../constants/constants_export.dart';
import '../models/attemot_info_model.dart';

enum AStatus { init, fetching, success, error }

class AttemptProvider extends ChangeNotifier {
  final DioClient _client = DioClient();
  AStatus status = AStatus.init;
  String message = '';

  ResultMeta? _resultMeta;

  final List<Map<String, dynamic>> _attemptsBody = [];

  AttemptInfo? _attemptInfo;

  AttemptInfo? get attemptInfo => _attemptInfo;

  List<Map<String, dynamic>> get attemptsBody => _attemptsBody;

  ResultMeta? get resultMeta => _resultMeta;


  Future<void> updateAttempt({
    required String attemptId,
    required Map<String, dynamic> attemptData,
    required int totalTimeTaken,
  }) async {
    status = AStatus.fetching;
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
        status = AStatus.success;
        message = 'Attempt updated successfully';

        await getAttemptInfo(attemptId);
      } else {
        status = AStatus.error;
        message = 'Failed to update attempt';
      }
    } catch (error) {
      status = AStatus.error;
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
    status = AStatus.fetching;
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
        status = AStatus.success;
        message = 'Result updated successfully';
      } else {
        status = AStatus.error;
        message = 'Failed to update result';
      }
    } catch (error) {
      status = AStatus.error;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }

  Future<void> getAttemptInfo(String attemptId) async {
    status = AStatus.fetching;
    notifyListeners();

    try {
      final response = await _client.get(Endpoints.getAttemptInfo(attemptId));

      if (response != null && response['success'] == true) {
        // Filter attempts for the specific attemptId
        final allAttempts = response['data']['attempts'] as List<dynamic>;
        final filteredAttempts = allAttempts.where((attempt) {
          return attempt['attemptId'] == attemptId;
        }).toList();

        if (filteredAttempts.isEmpty) {
          status = AStatus.error;
          message = 'No data available for attemptId $attemptId';
          notifyListeners();
          return;
        }

        // Calculate specific metrics for this attemptId
        final correctAttempts = filteredAttempts
            .where((attempt) => attempt['isCorrect'] == true)
            .length;
        final incorrectAttempts = filteredAttempts.where((attempt) =>
        attempt['isCorrect'] == false && attempt['attempted'] == true).length;
        final skippedAttempts = filteredAttempts.where((attempt) =>
        attempt['attempted'] == false || attempt['selection'] == null).length;

        // Calculate total and average time taken
        final totalTimeTaken = filteredAttempts.fold(0, (sum, attempt) => attempt['timeTaken'] ?? 0);
        final averageTimeTaken = filteredAttempts.isNotEmpty
            ? totalTimeTaken / filteredAttempts.length
            : 0;

        // Create attempt info with filtered data and calculated metrics
        _attemptInfo = AttemptInfo.fromJson({
          ...response['data'],
          'attempts': filteredAttempts,
          'correctAttempts': correctAttempts,
          'incorrectAttempts': incorrectAttempts,
          'skippedAttempts': skippedAttempts,
          'totalTimeTaken': totalTimeTaken,
          'averageTimeTaken': averageTimeTaken,
        });

        // Parse resultMeta
        final resultMetaJson = response['data']['resultMeta'];
        _resultMeta = ResultMeta.fromJson(resultMetaJson);

        status = AStatus.success;
        message = 'Attempt info fetched successfully';
      } else {
        status = AStatus.error;
        message = 'Failed to fetch attempt info';
      }
    } catch (error) {
      status = AStatus.error;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }
}
