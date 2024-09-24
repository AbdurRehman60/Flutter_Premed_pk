import '../../../api_manager/dio client/dio_client.dart';
import '../../../api_manager/dio client/endpoints.dart';
import '../../../constants/constants_export.dart';
import '../../../models/cheatsheetModel.dart';

enum CheatSheetsFetchStatus {
  init,
  fetching,
  success,
}

class CheatsheetsProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  CheatSheetsFetchStatus cheatSheetsLoadingStatus = CheatSheetsFetchStatus.init;
  CheatSheetsFetchStatus get vaultnotesLoadingstatus => cheatSheetsLoadingStatus;
  set notesLoadingStatus(CheatSheetsFetchStatus value) {
    cheatSheetsLoadingStatus = value;
  }

  List<VaultNotesModel> cheatSheetsList = [];
  List<VaultNotesModel> get vaultNotesList => cheatSheetsList;
  set cheatSheetList(List<VaultNotesModel> value) {
    cheatSheetsList = value;
  }

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchNotess() async {
    Map<String, Object?> result;
    cheatSheetsLoadingStatus = CheatSheetsFetchStatus.fetching;
    if (vaultNotesList.isNotEmpty) {
      notify();
    }
    cheatSheetList = [];

    try {
      final response = await _client.get(
        Endpoints.CheatSheets,
      );

      if (response["message"] == "Retrieved Successfully") {
        final List<VaultNotesModel> list = [];
        for (final data in response['data']) {
          final VaultNotesModel fetchedData = VaultNotesModel.fromJson(data);
          list.add(fetchedData);
        }

        cheatSheetList = list;

        cheatSheetsLoadingStatus = CheatSheetsFetchStatus.success;
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
    cheatSheetsLoadingStatus = CheatSheetsFetchStatus.init;
    notify();
    return result;
  }
}
