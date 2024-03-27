import 'package:flutter/cupertino.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../api_manager/dio client/endpoints.dart';

enum DeckFetchingStatus { Init, Fetching, Success, Error }

class DecksProvider extends ChangeNotifier {
  void fetchDecks() async {
    final DioClient dio = DioClient();
    try {
      final apiResponse =
          await dio.get(Endpoints.serverURL+Endpoints.Deckspoints);

    } catch (e) {
      print(e);
    }
  }
}
