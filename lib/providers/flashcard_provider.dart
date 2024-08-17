import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import '../models/flashcard_model.dart';
// Adjust import path if necessary

enum Status {
  init,
  fetching,
  success,
  error,
  removing, // Added for flashcard removal
}

enum RemovalStatus {
  init,
  removing,
  success,
  error,
}
class FlashcardProvider with ChangeNotifier {
  final DioClient _client = DioClient();

  Status _doubtUploadStatus = Status.init;
  Status get doubtUploadStatus => _doubtUploadStatus;
  set doubtUploadStatus(Status value) {
    _doubtUploadStatus = value;
    notifyListeners();
  }
  String _additionStatus = '';
  String get additionStatus =>  _additionStatus;

  RemovalStatus _removalStatus = RemovalStatus.init;
  RemovalStatus get removalStatus => _removalStatus;
  set removalStatus(RemovalStatus value) {
    _removalStatus = value;
    notifyListeners();
  }

  List<FlashcardModel> _flashcardData = [];
  List<FlashcardModel> get flashcardData => _flashcardData;
  set flashcardData(List<FlashcardModel> value) {
    _flashcardData = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getFlashcardsByUser(String userId) async {
    _doubtUploadStatus = Status.fetching;
    notifyListeners();

    try {
      final Response response = await _client.post(
        Endpoints.GetFlashcards,
        data: {'userId': userId},
      );

      if (response.data['success'] == true) {
        final List<dynamic> responseData = response.data['FindFlashcards'];
        final List<FlashcardModel> fetchedList = [];

        for (final data in responseData) {
          final qDetails = data['QDetails'];
          if (qDetails.isNotEmpty) {
            final flashcardDetails = qDetails[0];
            if (flashcardDetails['Published']) {
              final FlashcardModel flashcard = FlashcardModel.fromJson(data,flashcardDetails['_id']);
              fetchedList.add(flashcard);
            }
          }
        }

        flashcardData = fetchedList;

        _doubtUploadStatus = Status.success;
        return {
          'status': true,
          'message': "Fetched Successfully!",
        };
      } else {
        _doubtUploadStatus = Status.error;
        return {'status': false, 'message': 'Request failed'};
      }
    } on DioException catch (e) {
      _doubtUploadStatus = Status.error;
      return {
        'status': false,
        'message': e.message,
      };
    } finally {
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> removeFlashcard({
    required String userId,
    required String subject,
    required String questionId,
  }) async {
    _removalStatus = RemovalStatus.removing;
    notifyListeners();

    try {
      final Response response = await _client.post(
        Endpoints.handleCards,
        data: {
          'userId': userId,
          'subject': subject,
          'questionId': questionId,
        },
      );

      if (response.data['success'] == true) {
        final flashCardStatuss = response.data['action'];

        if(flashCardStatuss == 'Removed'){

          _additionStatus = 'Removed';
          notifyListeners();
        }else if (flashCardStatuss == 'Added'){
          _additionStatus = 'Added';
          notifyListeners();

        }

        // print('questionId : $questionId');
        // print('userId : $userId, subject : $subject, questionId : $questionId');
        _removalStatus = RemovalStatus.success;

        await getFlashcardsByUser(userId);

        return {
          'status': true,
          'message': "Flashcard removed successfully!",
        };
      } else {
        _removalStatus = RemovalStatus.error;
        return {'status': false, 'message': 'Failed to remove flashcard'};
      }
    } on DioException catch (e) {
      _removalStatus = RemovalStatus.error;
      return {
        'status': false,
        'message': e.message,
      };
    } finally {
      notifyListeners();
    }
  }

  List<FlashcardModel> getFilteredFlashcards(String subject) {
    return flashcardData.where((flashcard) {
      return flashcard.subject == subject;
    }).toList();
  }
}
