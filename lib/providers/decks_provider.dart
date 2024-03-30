import 'package:flutter/cupertino.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/deck_model.dart';

import '../api_manager/dio client/endpoints.dart';

enum FetchStatus { init, fetching, success, error }

enum DeckType { yearly, topical }

class DecksProvider extends ChangeNotifier {
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
    fetchUserdecks();
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

  Future<List> fetchUserdecks() async {
    final DioClient _client = DioClient();
    Map<String, dynamic> result;
    // _loadingStatus = UserStatStatus.Fetching;

    try {
      // print('fetching');
      final responseData =
          await _client.get(Endpoints.serverURL + Endpoints.Deckspoints);
      print(responseData);
      if (responseData['success']) {
        final List deckCategories = responseData['data'];
        final mdCATQBANK = deckCategories[7];
        final List mdcatDeckGroups = mdCATQBANK['deckGroups'];
        final requiredDecks = mdcatDeckGroups.where((category) {
          return category['deckGroupName'] == 'MDCAT 2023' ||
              category['deckGroupName'] == 'MDCAT 2022' ||
              category['deckGroupName'] == 'Punjab MDCAT' ||
              category['deckGroupName'] == 'Sindh MDCAT' ||
              category['deckGroupName'] == 'KPK MDCAT' ||
              category['deckGroupName'] == 'Federal MDCAT' ||
              category['deckGroupName'] == 'Balochistan MDCAT';
        }).toList();
        final List<DeckModel> decks = [];
        for (var deck in requiredDecks) {
          final DeckModel deckModel = DeckModel.fromJson(deck);
          decks.add(deckModel);
        }
        _deckList = decks;
        print(_deckList.length);
        notify();
        return _deckList;
        result = {'status': false, 'message': 'd'};
      } else {
        result = {
          'status': false,
          'message': responseData["message"],
        };
      }
    } on DioError catch (e) {
      // _loadingStatus = UserStatStatus.Error;
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    return [];
  }

  Future<Map<String, dynamic>> fetchDecks() async {
    Map<String, dynamic> result;
    _fetchstatus = FetchStatus.fetching;
    final DioClient dio = DioClient();
    try {
      final responseData =
          await dio.get(Endpoints.serverURL + Endpoints.Deckspoints);
      if (responseData['success']) {
        final List deckCategories = responseData['data'];
        final mdcatQBankCategory = deckCategories.firstWhere(
          (category) => category['categoryName'] == 'MDCAT QBank',
        );
        print(mdcatQBankCategory);
        final List mdcatDeckGroups = mdcatQBankCategory['deckGroups'];
        final requiredDecks = mdcatDeckGroups.where((category) {
          if (decktype == DeckType.yearly) {
            return category['deckType'] == 'Yearly';
          } else {
            return category['deckType'] == 'Topical';
          }
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
