import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import '../api_manager/dio client/dio_client.dart';
import '../constants/constants_export.dart';
import '../models/deck_information_model.dart';

enum FetchStatus { idle, loading, success, error }

class DeckProvider extends ChangeNotifier {
  factory DeckProvider() => _instance;

  DeckProvider._internal();
  static final DeckProvider _instance = DeckProvider._internal();
  final DioClient _client = DioClient();

  DeckInformation? _deckInformation;
  DeckInformation? get deckInformation => _deckInformation;

  FetchStatus _fetchStatus = FetchStatus.idle;
  FetchStatus get fetchStatus => _fetchStatus;

  Future<void> fetchDeckInformation(String category, String deckGroup, String deckName, String userId) async {
    _fetchStatus = FetchStatus.loading;
    notifyListeners();

    try {
      final response = await _client.post(
        Endpoints.getDeckInfo,
        data: {
          'category': category,
          'deckgroup': deckGroup,
          'deckname': deckName,
          'userId': userId,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        print('Response Data: ${const JsonEncoder.withIndent('  ').convert(response.data)}');
        _deckInformation = DeckInformation.fromJson(responseData);
        _fetchStatus = FetchStatus.success;
      } else {
        _fetchStatus = FetchStatus.error;
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching deck information: $e');
      _fetchStatus = FetchStatus.error;
      notifyListeners();
    }
  }


}
