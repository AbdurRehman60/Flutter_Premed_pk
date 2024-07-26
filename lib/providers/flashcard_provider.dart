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
}

class FlashcardProvider with ChangeNotifier {
  final DioClient _client = DioClient();

  Status _doubtUploadStatus = Status.init;
  Status get doubtUploadStatus => _doubtUploadStatus;
  set doubtUploadStatus(Status value) {
    _doubtUploadStatus = value;
    notifyListeners();
  }

  List<FlashcardModel> _flashcardData = [];
  List<FlashcardModel> get flashcardData => _flashcardData;
  set flashcardData(List<FlashcardModel> value) {
    _flashcardData = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getFlashcardsByUser() async {
    _doubtUploadStatus = Status.fetching;
    notifyListeners();

    try {
      final Response response = await _client.post(
        Endpoints.GetFlashcards,
        data: {'userId': '64c68bc9f093d0bd25c026de'},
      );

      if (response.data['success'] == true) {
        print('step 1');
        final List<dynamic> responseData = response.data['FindFlashcards'];
        final List<FlashcardModel> fetchedList = [];

        for (final data in responseData) {
          final flashcardDetails = data['QDetails'][0];
          if (flashcardDetails['Published']) {
            final FlashcardModel flashcard = FlashcardModel.fromJson(data);
            fetchedList.add(flashcard);
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

  List<FlashcardModel> getFilteredFlashcards(String subject) {
    return flashcardData.where((flashcard) {
      return flashcard.subject == subject;
    }).toList();
  }
}
