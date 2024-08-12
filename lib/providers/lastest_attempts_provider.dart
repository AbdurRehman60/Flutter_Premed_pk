import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import '../constants/constants_export.dart';

enum FetchAttemptStatus { init, fetching, success, error }

class LatestAttemptPro extends ChangeNotifier {
  final DioClient _dioClient = DioClient();
  LatestAttempt? _latestAttempt;
  FetchAttemptStatus _status = FetchAttemptStatus.init;
  String? _error;

  LatestAttempt? get latestAttempt => _latestAttempt;
  FetchAttemptStatus get status => _status;
  String? get error => _error;
  final userProvider = UserProvider().user?.userId;

  Future<void> fetchLatestAttempt(context) async {
    _status = FetchAttemptStatus.fetching;
    notifyListeners();

    try {
      final res = await _dioClient.post(Endpoints.attemptPoints,
          data: {'userId': UserProvider().user?.userId});

      if (res.data['success']) {
        if (kDebugMode) {
          print('1');
        }
        _latestAttempt = LatestAttempt.fromJson(res.data['Result']);
        if (kDebugMode) {
          print('attempt L : ${_latestAttempt?.results.first.attemptMode}');
        }
        _status = FetchAttemptStatus.success;
      } else {
        _error = 'Failed to load latest attempt';
        _status = FetchAttemptStatus.error;
      }
    } on DioException catch (e) {
      _error = e.toString();
      _status = FetchAttemptStatus.error;
    } finally {
      notifyListeners();
    }
  }
}

class LatestAttempt {
  LatestAttempt({required this.id, required this.results});

  factory LatestAttempt.fromJson(Map<String, dynamic> json) {
    return LatestAttempt(
      id: json['_id'],
      results:
          (json['results'] as List).map((i) => Attempt.fromJson(i)).toList(),
    );
  }
  final String id;
  final List<Attempt> results;
}

class Attempt {
  Attempt({
    required this.id,
    required this.deckId,
    required this.userId,
    required this.attempts,
    required this.attemptMode,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.attemptedDate,
    required this.totalAttempts,
    required this.mode,
    required this.deckName,
    required this.totalQuestions,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) {
    final attemptsJson = json['attempts'];
    return Attempt(
      id: attemptsJson['_id'] ?? '',
      deckId: attemptsJson['deckId'] ?? '',
      userId: attemptsJson['userId'] ?? '',
      attempts: attemptsJson['attempts'] ?? [],
      attemptMode: attemptsJson['attemptMode'] ?? '',
      metadata: Metadata.fromJson(attemptsJson['metadata'] ?? {}),
      createdAt: attemptsJson['createdAt'] ?? '',
      updatedAt: attemptsJson['updatedAt'] ?? '',
      v: attemptsJson['__v'] ?? 0,
      attemptedDate: json['attemptedDate'] ?? '',
      totalAttempts: json['totalAttempts'] ?? 0,
      mode: json['mode'] ?? '',
      deckName: json['deckName'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,
    );
  }
  final String id;
  final String deckId;
  final String userId;
  final List<dynamic> attempts;
  final String attemptMode;
  final Metadata metadata;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String attemptedDate;
  final int totalAttempts;
  final String mode;
  final String deckName;
  final int totalQuestions;
}

class Metadata {
  Metadata({required this.entity, required this.category});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      entity: json['entity'] ?? '',
      category: json['category'] ?? '',
    );
  }
  final String entity;
  final String category;
}
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

// import 'package:premedpk_mobile_app/constants/constants_export.dart';
// import 'package:premedpk_mobile_app/models/lastest_attempts.dart';
//
// class LatestAttemptProvider with ChangeNotifier {
//   LatestAttempt? _latestAttempt;
//   bool _isLoading = false;
//   String? _error;
//
//   LatestAttempt? get latestAttempt => _latestAttempt;
//   bool get isLoading => _isLoading;
//   String? get latestAttemptError => _error;
//
//   final Dio _dio = Dio();
//
//   Future<void> fetchLatestAttempt(String userId) async {
//     _isLoading = true;
//     notifyListeners();
//     try {
//       final response = await _dio.post(
//         'https://prodapi.premed.pk/api/attempts/get-latest-attempt',
//         data: {'userId': userId},
//       );
//
//       if (response.statusCode == 200) {
//         final jsonData = response.data;
//         final latestAttempt = LatestAttempt.fromJson(jsonData);
//         _latestAttempt = latestAttempt;
//         _error = null;
//       } else {
//         _error = 'Failed to load latest attempt';
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   @override
//   void notifyListeners() {}
// }