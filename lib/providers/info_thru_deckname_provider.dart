import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';

enum Status { idle, fetching, success, error }

class DeckInfoProvider with ChangeNotifier {
  final DioClient _client = DioClient();
  Map<String, dynamic>? _deckInfo;
  Status status = Status.idle;
  String? message;

  Map<String, dynamic>? get deckInfo => _deckInfo;

  Future<void> getDeckInfo(String deckname) async {
    status = Status.fetching;
    notifyListeners();

    try {
      final response = await _client.post(Endpoints.getdeckinfothrudeckname(deckname));
      if (response.data['success'] == true && response.data.containsKey('deck')) {
        _deckInfo = response.data['deck'];

        if (_deckInfo?['questions'] != null && _deckInfo!['questions'] is List) {
          message = 'Deck info and questions fetched successfully';
        } else {
          message = 'Deck info fetched, but questions list is null or empty';
        }

        status = Status.success;
      } else {
        status = Status.error;
        message = 'Failed to fetch deck info';
      }
    } catch (error) {
      status = Status.error;
      message = 'Error: $error';
    } finally {
      notifyListeners();
    }
  }
}
