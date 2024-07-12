import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/models/mnemonics_model.dart';

import '../../api_manager/dio client/dio_client.dart';
import '../../api_manager/dio client/endpoints.dart';
import '../../constants/constants_export.dart';

enum FetchStatus {
  init,
  fetching,
  success,
  error,
}

class MnemonicsProvider extends ChangeNotifier {
  FetchStatus _fetchStatus = FetchStatus.init;
  FetchStatus get fetchStatus => _fetchStatus;

  List<MnemonicsModel> _mnemonicsList = [];
  List<MnemonicsModel> get mnemonicsList => _mnemonicsList;

  void notify() {
    notifyListeners();
  }

  Future<void> getMnemonics() async {
    try {
      _fetchStatus = FetchStatus.fetching;
      notify();

      final List<MnemonicsModel> fetchedMnemonicsList = [];

      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.Mnemonics);
      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> mnemonicsData =
            List<Map<String, dynamic>>.from(responseData['data']);
        for (final data in mnemonicsData) {
          final MnemonicsModel mnemonic = MnemonicsModel.fromJson(data);
          fetchedMnemonicsList.add(mnemonic);
        }
        _mnemonicsList = fetchedMnemonicsList;
        _fetchStatus = FetchStatus.success;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _fetchStatus = FetchStatus.error;
    } finally {
      notify();
    }
  }
}
