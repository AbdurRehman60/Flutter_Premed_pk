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

  // Define the resultMeta getter to expose _resultMeta
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

        // Fetch attempt info after successful update
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


  // Future<void> updateAttempt({
  //   required String attemptId,
  //   required Map<String, dynamic> attemptData,
  //   required int totalTimeTaken,
  // }) async {
  //   status = Status.fetching;
  //   notifyListeners();
  //
  //   _attemptsBody.add(attemptData);
  //
  //   try {
  //     final response = await _client.patch(
  //       Endpoints.updateAttempt(attemptId),
  //       data: {
  //         'attemptsBody': _attemptsBody,
  //         'totalTimeTaken': totalTimeTaken,
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       status = Status.success;
  //       message = 'Attempt updated successfully';
  //     } else {
  //       status = Status.error;
  //       message = 'Failed to update attempt';
  //     }
  //   } catch (error) {
  //     status = Status.error;
  //     message = 'Error: $error';
  //   } finally {
  //     notifyListeners();
  //   }
  // }

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
        // Parse the AttemptInfo from the API response
        _attemptInfo = AttemptInfo.fromJson(response['data']);

        // Parse resultMeta separately if necessary
        final resultMetaJson = response['data']['resultMeta']; // Extract resultMeta JSON
        _resultMeta = ResultMeta.fromJson(resultMetaJson);     // Parse into ResultMeta object

        // Now, access the attempted value from resultMeta
        final attempted = _resultMeta?.attempted ?? 0; // Use the attempted value from resultMeta

        // You can now use `attempted` wherever you need it
        print('Attempted: $attempted'); // Example usage of attempted

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