import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';

import '../../api_manager/dio client/dio_client.dart';
import '../../api_manager/dio client/endpoints.dart';
import '../../constants/constants_export.dart';

enum Status {
  init,
  fetching,
  success,
}

class VaultStudyNotesProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _vaultnotesLoadingStatus = Status.init;
  Status get vaultnotesLoadingstatus => _vaultnotesLoadingStatus;


  List<VaultNotesModel> _vaultNotesList = [];
  List<VaultNotesModel> get vaultNotesList => _vaultNotesList;
  set cheatSheetList(List<VaultNotesModel> value) {
    _vaultNotesList = value;
  }

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchNotess() async {
    Map<String, Object?> result;
    _vaultnotesLoadingStatus = Status.fetching;
    if (vaultNotesList.isNotEmpty) {
      notify();
    }
    cheatSheetList = [];

    try {
      final response = await _client.get(
        Endpoints.StudyNotes,
      );

      if (response["message"] == "Retrieved Successfully") {
        final List<VaultNotesModel> list = [];
        for (final data in response['data']) {
          final VaultNotesModel fetchedData = VaultNotesModel.fromJson(data);
          list.add(fetchedData);
        }

        cheatSheetList = list;

        _vaultnotesLoadingStatus = Status.success;
        notify();
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
    _vaultnotesLoadingStatus = Status.init;
    notify();
    return result;
  }
}
