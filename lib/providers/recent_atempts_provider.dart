import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/recent_attempts_model.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';

// class RecentAttemptsProvider with ChangeNotifier {
//   List<RecentAttempt> _recentAttempts = [];
//
//   List<RecentAttempt> get recentAttempts => _recentAttempts;
//
//   final Dio _dio = Dio();
//   final userProvider = UserProvider().user?.userId;
//
//   Future<void> fetchRecentAttempts() async {
//     try {
//       final response = await _dio.post(
//         Endpoints.RecentAttempts,
//         data: {'userId': UserProvider().user?.userId},
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = response.data;
//         _recentAttempts = (jsonData['Result'] as List)
//             .map((e) => RecentAttempt.fromJson(e))
//             .toList();
//         notifyListeners();
//       } else {
//         throw Exception(
//             'Failed to load recent attempts: ${response.statusMessage}');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error fetching recent attempts: $e');
//       }
//       _recentAttempts = []; // clear the list on error
//       notifyListeners(); // notify listeners of the error
//       rethrow; // rethrow the original exception
//     }
//   }
// }


class RecentAttemptsProvider with ChangeNotifier {
  List<RecentAttempt> _recentAttempts = [];
  List<RecentAttempt> get recentAttempts => _recentAttempts;

  final Dio _dio = Dio();

  Future<void> fetchRecentAttempts(String userId) async {
    try {
      final response = await _dio.post(
        Endpoints.RecentAttempts,
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;
        _recentAttempts = (jsonData['Result'] as List)
            .map((e) => RecentAttempt.fromJson(e))
            .toList();
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load recent attempts: ${response.statusMessage}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching recent attempts: $e');
      }
      _recentAttempts = []; // clear the list on error
      notifyListeners(); // notify listeners of the error
      rethrow; // rethrow the original exception
    }
  }
}