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
  Status get loadingStatus => _loadingStatus;
  set loadingStatus(Status value) {
    _loadingStatus = value;
  }

  List<NoteModel> _guidesList = [];
  List<NoteModel> get guidesList => _guidesList;
  set guidesList(List<NoteModel> value) {
    _guidesList = value;
  }

  List<NoteModel> _notesList = [];
  List<NoteModel> get notesList => _notesList;
  set notesList(List<NoteModel> value) {
    _notesList = value;
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchGuides() async {
    var result;
    _loadingStatus = Status.Fetching;
    notify();

    try {
      final response = await _client.get(
        Endpoints.Guides,
      );

      if (response["message"] == "Guide fetched successfully") {
        for (final data in response['data']) {
          NoteModel fetchedData = NoteModel.fromJson(data);
          guidesList.add(fetchedData);
        }

        result = {
          'status': true,
          'message': 'Data fetched successfully',
        };
      } else {
        result = {
          'status': false,
          'message': 'Failed to fetch data',
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
        Endpoints.RevisionNotes,
      );

      if (response["message"] == "Notes fetched successfully") {
        for (final data in response['data']) {
          NoteModel fetchedData = NoteModel.fromJson(data);
          notesList.add(fetchedData);
        }

        result = {
          'status': true,
          'message': 'Data fetched successfully',
        };
      } else {
        result = {
          'status': false,
          'message': 'Failed to fetch data',
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
