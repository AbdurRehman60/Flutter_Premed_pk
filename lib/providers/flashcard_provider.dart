// ignore_for_file: constant_identifier_names, unnecessary_getters_setters, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/flashcard_model.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';

enum Status {
  Init,
  Fetching,
  Error,
}

class FlashcardProvider with ChangeNotifier {
  final DioClient _client = DioClient();

  Status _doubtUploadStatus = Status.Init;
  Status get doubtUploadStatus => _doubtUploadStatus;
  set doubtUploadStatus(Status value) {
    _doubtUploadStatus = value;
  }

  List<FlashcardModel> _flashcardData = [];
  List<FlashcardModel> get flashcardData => _flashcardData;
  set flashcardData(List<FlashcardModel> value) {
    _flashcardData = value;
  }

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> getFlashcardsByUser() async {
    Map<String, Object?> result;

    _doubtUploadStatus = Status.Fetching;

    try {
      final Response response = await _client.post(
        Endpoints.GetFlashcards,
        data: {
          "username": UserProvider().getEmail(),
        },
      );

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(response.data);
        final List<FlashcardModel> fetchedList = [];
        for (final data in responseData) {
          final FlashcardModel flashcard = FlashcardModel.fromJson(data);
          fetchedList.add(flashcard);
        }
        flashcardData = fetchedList;

        result = {
          'status': true,
          'message': "Fetched Successfully!",
        };
      } else {
        _doubtUploadStatus = Status.Error;
        notify();

        // Returning results
        result = {'status': false, 'message': 'Request failed'};
      }
    } on DioError catch (e) {
      _doubtUploadStatus = Status.Init;
      notify();
      result = {
        'status': false,
        'message': e.message,
      };
    }

    notify();
    return result;
  }

  List<FlashcardModel> getFilteredFlashcards(String subject) {
    return flashcardData.where((flashcard) {
      return flashcard.tags.contains(subject);
    }).toList();
  }
}
