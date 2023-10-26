import 'package:dio/dio.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

enum Status {
  Init,
  Fetching,
  Success,
}

class NotesProvider extends ChangeNotifier {
  final DioClient _client = DioClient();
  Status _loadingStatus = Status.Init;
  List<Note> guidesList = [];

  Status get loadingStatus => _loadingStatus;

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchGuides() async {
    var result;
    _loadingStatus = Status.Fetching;
    notify();

    try {
      final response = await _client.get(
        Endpoints.guides,
      );

      if (response["message"] == "Guide fetched successfully") {
        for (final guideData in response['data']) {
          Note fetchedGuide = Note.fromJson(guideData);
          guidesList.add(fetchedGuide);
        }

        result = {
          'status': true,
          'message': 'Guides fetched successfully',
        };
      } else {
        result = {
          'status': false,
          'message': 'Failed to fetch guides',
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }

    _loadingStatus = Status.Init;
    notify();

    return result;
  }

  Future<Map<String, dynamic>> fetchNotes() async {
    var result;
    _loadingStatus = Status.Fetching;
    notify();

    try {
      final response = await _client.get(
        Endpoints.revisionNotes,
      );

      if (response["message"] == "Guide fetched successfully") {
        for (final guideData in response['data']) {
          Note fetchedGuide = Note.fromJson(guideData);
          guidesList.add(fetchedGuide);
        }

        result = {
          'status': true,
          'message': 'Guides fetched successfully',
        };
      } else {
        result = {
          'status': false,
          'message': 'Failed to fetch guides',
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }

    _loadingStatus = Status.Init;
    notify();

    return result;
  }
}
