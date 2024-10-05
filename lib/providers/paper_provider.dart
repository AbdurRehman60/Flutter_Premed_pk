
import 'package:premedpk_mobile_app/providers/user_provider.dart';

import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import '../constants/constants_export.dart';
import '../models/paper_model.dart';

enum PaperFetchStatus { idle, loading, success, error }

class PaperProvider extends ChangeNotifier {

  Paper? pastPaper;
  Paper? practicePaper;
  PaperResponse? _deckInformation;
  PaperResponse? get deckInformation => _deckInformation;



  PaperFetchStatus _fetchStatus = PaperFetchStatus.idle;
  PaperFetchStatus get fetchStatus => _fetchStatus;

  final DioClient _client = DioClient();


  Future<void> fetchPapers(String category, String deckGroup, String deckName, String userId) async {
    print("this is the category error $category");
    print(deckGroup);
    print("deckname being passed is $deckName");
    print(userId);
    _fetchStatus = PaperFetchStatus.loading;
    notifyListeners();

    try {
      final response = await _client.post(
        Endpoints.getPapers,
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
        _deckInformation = PaperResponse.fromJson(responseData);
        _fetchStatus = PaperFetchStatus.success;
      } else {
        _fetchStatus = PaperFetchStatus.error;
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching deck information: $e');
      _fetchStatus = PaperFetchStatus.error;
      notifyListeners();
    }
  }
}
