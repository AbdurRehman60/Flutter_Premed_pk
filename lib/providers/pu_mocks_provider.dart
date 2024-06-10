import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';

import '../api_manager/dio client/endpoints.dart';

enum FetchStatus { init, fetching, success, error }

class PrivuniMocksProvider extends ChangeNotifier {
  FetchStatus _fetchStatus = FetchStatus.init;
  FetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];
  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = FetchStatus.fetching;
      notifyListeners();
      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.Privuni);
      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? privuniMocksCategory;
        try {
          privuniMocksCategory = data.firstWhere(
                (category) => category['categoryName'] == 'Private Universities Mocks',
          );
        } catch (e) {
          privuniMocksCategory = null;
        }
        if (privuniMocksCategory != null) {
          final List<dynamic> deckGroupsData = privuniMocksCategory['deckGroups'];
          _deckGroups = deckGroupsData.map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.map((deck) {
              return DeckItem(
                  deckName: deck['deckName'] as String,
                  deckLogo: deck['deckLogo'] as String,
                  premiumTag: deck['premiumTags'] != null &&
                      (deck['premiumTags'] as List).isNotEmpty
                      ? (deck['premiumTags'][0] as String)
                      : 'Free',
                  deckInstructions: deck['deckInstructions'] as String,
                isTutorModeFree: deck['isTutorModeFree'],
                timedTestMode: deck['timedTestMode'],
                timesTestminutes: deck['timedTestMinutes'],
              );
            }).toList();
            final int deckNameCount = deckItems.length;
            final String deckGroupImage = deckGroupData['deckGroupImage'];
            return DeckGroupModel(
              deckType: deckGroupData['deckType'],
              deckGroupName: deckGroupData['deckGroupName'],
              deckItems: deckItems,
              deckNameCount: deckNameCount,
              deckGroupImage: deckGroupImage,
            );
          }).toList();

          _fetchStatus = FetchStatus.success;
        } else {
          _fetchStatus = FetchStatus.error;
        }
      } else {
        _fetchStatus = FetchStatus.error;
      }
    } catch (e) {
      _fetchStatus = FetchStatus.error;
    } finally {
      notifyListeners();
    }
  }

}
