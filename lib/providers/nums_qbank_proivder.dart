
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import '../constants/constants_export.dart';
import '../models/deck_model.dart';

enum FetchStatus { init, fetching, success, error }

enum DeckType { yearly, topical }

class NumsBankProvider extends ChangeNotifier {
  FetchStatus _fetchstatus = FetchStatus.init;
  FetchStatus get fetchstatus => _fetchstatus;

  DeckType _decktype = DeckType.yearly;
  DeckType get decktype => _decktype;

  void changeDecktype() {
    if (decktype == DeckType.yearly) {
      _decktype = DeckType.topical;
      notify();
    } else if (decktype == DeckType.topical) {
      _decktype = DeckType.yearly;
    }
    // fetchUserdecks();
    notify();
  }

  List<DeckModel> _deckList = [];
  List<DeckModel> get deckList => _deckList;
  set notesList(List<DeckModel> value) {
    _deckList = value;
  }

  void notify() {
    notifyListeners();
  }


  Future<Map<String, dynamic>> fetchDecks(String deckType) async {
    Map<String, dynamic> result;
    _fetchstatus = FetchStatus.fetching;
    final DioClient dio = DioClient();
    try {
      final responseData =
      await dio.get(Endpoints.serverURL + Endpoints.Deckspoints);
      if (responseData['success']) {
        final List deckCategories = responseData['data'];
        final mdcatQBankCategory = deckCategories.firstWhere(
              (category) => category['categoryName'] == deckType,
        );
        print(mdcatQBankCategory);
        final List mdcatDeckGroups = mdcatQBankCategory['deckGroups'];
        final requiredDecks = mdcatDeckGroups.where((category) {
          return category['deckType'] == 'Topical';
          // if (decktype == DeckType.yearly) {
          //   return category['deckType'] == 'Yearly';
          // } else {
          //   return category['deckType'] == 'Topical';
          // }
        }).toList();
        // print(requiredDecks.length);
        final List<DeckModel> decks = [];
        for (var deck in requiredDecks) {
          final DeckModel deckModel = DeckModel.fromJson(deck);
          decks.add(deckModel);
        }
        _deckList = decks;
        print(_deckList.length);
        notify();
      } else {
        result = {
          'status': false,
          'message': responseData["message"],
        };
      }
      result = {
        'status': true,
        'message': responseData["message"],
      };
    } on DioError catch (e) {
      _fetchstatus = FetchStatus.error;
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    return result;
  }
}
