// // latest_attempt_provider.dart

// import 'package:premedpk_mobile_app/constants/constants_export.dart';
// import 'package:premedpk_mobile_app/models/lastest_attempts.dart';

// class LatestAttemptProvider with ChangeNotifier {
//   LatestAttempt? _latestAttempt;
//   String? _latestAttemptError;

//   LatestAttempt? get latestAttempt => _latestAttempt;
//   String? get latestAttemptError => _latestAttemptError;

//   Future<void> fetchLatestAttempt(String userId) async {
//     final dio = Dio();
//     const url = 'https://prodapi.premed.pk/api/attempts/get-latest-attempt';
//     try {
//       final response = await dio.post(
//         url,
//         data: {'userId': int.parse(userId)},
//         options: Options(
//           contentType: Headers.jsonContentType,
//         ),
//       );
//       if (response.statusCode == 200) {
//         final jsonData = response.data;
//         if (jsonData != null && jsonData['Result'] != null) {
//           final resultList = jsonData['Result'] as List;
//           if (resultList.isNotEmpty) {
//             _latestAttempt = LatestAttempt.fromJson(resultList.first);
//             _latestAttemptError = null;
//           } else {
//             _latestAttemptError = 'No latest attempt found';
//           }
//         } else {
//           _latestAttemptError = 'Invalid API response';
//         }
//       } else {
//         _latestAttemptError = 'Failed to load latest attempt';
//         throw Exception('Failed to load latest attempt');
//       }
//     } catch (error) {
//       _latestAttemptError = error.toString();
//     } finally {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         notifyListeners();
//       });
//     }
//   }
// }

import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/lastest_attempts.dart';

class LatestAttemptProvider with ChangeNotifier {
  LatestAttempt? _latestAttempt;
  bool _isLoading = false;
  String? _error;

  LatestAttempt? get latestAttempt => _latestAttempt;
  bool get isLoading => _isLoading;
  String? get latestAttemptError => _error;

  final Dio _dio = Dio();

  Future<void> fetchLatestAttempt(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _dio.post(
        'https://prodapi.premed.pk/api/attempts/get-latest-attempt',
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        final latestAttempt = LatestAttempt.fromJson(jsonData);
        _latestAttempt = latestAttempt;
        _error = null;
      } else {
        _error = 'Failed to load latest attempt';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {}
}
