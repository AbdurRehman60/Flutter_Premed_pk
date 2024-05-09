import 'package:flutter/cupertino.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/deck_model.dart';

import '../api_manager/dio client/endpoints.dart';

enum FetchStatus { init, fetching, success, error }

enum DeckType { yearly, topical }

class DecksProvider extends ChangeNotifier {
  bool _changeColor = true;
  bool get changeColor => _changeColor;

  void resetState() {
    _changeColor = true;
  }

  FetchStatus _fetchstatus = FetchStatus.init;
  FetchStatus get fetchstatus => _fetchstatus;

  DeckType _decktype = DeckType.yearly;
  DeckType get decktype => _decktype;

  void getYearlyDecks() {
    _deckList = _allDecks.where((deck) => deck.deckType == 'Yearly').toList();
    _decktype = DeckType.yearly;
    _changeColor = !_changeColor;
    notify();
  }

  void getTopicalDecks() {
    _deckList = _allDecks.where((deck) => deck.deckType == 'Topical').toList();
    _decktype = DeckType.topical;
    _changeColor = !_changeColor;
    notify();
  }

  List<DeckModel> _deckList = [];
  List<DeckModel> get deckList => _deckList;

  set notesList(List<DeckModel> value) {
    _deckList = value;
  }

  List<DeckModel> _allDecks = [];
  List<DeckModel> get allDecks => _allDecks;

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchDecks(String deckType) async {
    resetState();
    Map<String, dynamic> result;
    _fetchstatus = FetchStatus.fetching;
    final DioClient dio = DioClient();
    try {
      final responseData =
          await dio.get(Endpoints.serverURL + Endpoints.Deckspoints);

      if (responseData['success']) {
        final List deckCategories = responseData['data'];
        final requiredDeckBank = deckCategories
            .firstWhere((category) => category['categoryName'] == deckType);
        final List mdcatDeckGroups = requiredDeckBank['deckGroups'];
        final yearlyDecks = mdcatDeckGroups.where((category) {
          return category['deckType'] == 'Yearly';
        }).toList();
        final List<DeckModel> decksYearly = [];
        for (var deck in yearlyDecks) {
          final DeckModel deckModel = DeckModel.fromJson(deck);
          decksYearly.add(deckModel);
        }
        _deckList = decksYearly;
        // print(requiredDecks.length);
        final List<DeckModel> decks = [];
        for (var deck in mdcatDeckGroups) {
          final DeckModel deckModel = DeckModel.fromJson(deck);
          decks.add(deckModel);
        }
        _allDecks = decks;
        // print(_deckList.length);
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
