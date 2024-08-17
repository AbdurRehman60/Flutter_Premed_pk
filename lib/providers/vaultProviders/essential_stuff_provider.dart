import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/models/essence_stuff_model.dart';

import '../../api_manager/dio client/dio_client.dart';
import '../../api_manager/dio client/endpoints.dart';
import '../../constants/constants_export.dart';

enum FetchStatus {
  init,
  fetching,
  success,
  error,
}

class EssentialStuffProvider extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }

  FetchStatus _fetchStatus = FetchStatus.init;
  FetchStatus get fetchStatus => _fetchStatus;

  List<EssenceStuffModel> _essentialStuffList = [];
  List<EssenceStuffModel> get essentialStuffList => _essentialStuffList;

  Future<void> getEssentialStuff() async {
    try {
      _fetchStatus = FetchStatus.fetching;
      notify();
      // if (essentialStuffList.isNotEmpty) {
      //   notify();
      // }

      final List<EssenceStuffModel> essenceStuffList = [];

      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.EssentialStuff);
      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> essentialStuffData =
            List<Map<String, dynamic>>.from(responseData['data']);
        for (final data in essentialStuffData) {
          final EssenceStuffModel note = EssenceStuffModel.fromJson(data);
          essenceStuffList.add(note);
        }
        _essentialStuffList = essenceStuffList;
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
