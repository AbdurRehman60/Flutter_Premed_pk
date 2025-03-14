import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/endpoints.dart';
import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';

enum NotesStatus { init, fetching, success, error }

class VaultTopicalGuidesProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  NotesStatus _vaultnotesLoadingStatus = NotesStatus.init;
  NotesStatus get vaultnotesLoadingstatus => _vaultnotesLoadingStatus;

  List<VaultNotesModel> _vaultNotesList = [];
  List<VaultNotesModel> get vaultNotesList => _vaultNotesList;

  void notify() {
    notifyListeners();
  }
  Future<Map<String, dynamic>> fetchNotess() async {

    Map<String, Object?> result;
    _vaultnotesLoadingStatus = NotesStatus.fetching;
    if(vaultNotesList.isNotEmpty){
    notify();}

    try {
      final response = await _client.get(
        Endpoints.TopicalNotes,
      );

      if (response["message"] == "Topical Guide retrieved successfully") {
        final List<VaultNotesModel> list = [];
        for (final data in response['data']) {
          final VaultNotesModel fetchedData = VaultNotesModel.fromJson(data);
          list.add(fetchedData);
        }

        _vaultNotesList = list;

        _vaultnotesLoadingStatus = NotesStatus.success;
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
    } on DioException catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }

    _vaultnotesLoadingStatus = NotesStatus.init;
    notify();
    return result;
  }
}
