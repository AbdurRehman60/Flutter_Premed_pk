// latest_attempt_provider.dart

import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/lastest_attempts.dart';

class LatestAttemptProvider with ChangeNotifier {
  LatestAttempt? _latestAttempt;
  String? _latestAttemptError;

  LatestAttempt? get latestAttempt => _latestAttempt;
  String? get latestAttemptError => _latestAttemptError;

  Future<void> fetchLatestAttempt(String userId) async {
    final dio = Dio();
    const url = 'https://your-api-url.com/get-latest-attempt';
    try {
      final response = await dio.post(
        url,
        data: {'userId': int.parse(userId)},
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      if (response.statusCode == 200) {
        final jsonData = response.data;
        if (jsonData != null && jsonData['Result'] != null) {
          final resultList = jsonData['Result'] as List;
          if (resultList.isNotEmpty) {
            _latestAttempt = LatestAttempt.fromJson(resultList.first);
            _latestAttemptError = null;
          } else {
            _latestAttemptError = 'No latest attempt found';
          }
        } else {
          _latestAttemptError = 'Invalid API response';
        }
      } else {
        _latestAttemptError = 'Failed to load latest attempt';
        throw Exception('Failed to load latest attempt');
      }
    } catch (error) {
      _latestAttemptError = error.toString();
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
