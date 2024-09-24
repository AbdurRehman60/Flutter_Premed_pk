import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';

import '../api_manager/dio client/endpoints.dart';

enum PuMocksFetchStatus { init, fetching, success, error }

class PrivuniMocksProvider extends ChangeNotifier {
  PuMocksFetchStatus _fetchStatus = PuMocksFetchStatus.init;
  PuMocksFetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];
  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = PuMocksFetchStatus.fetching;
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
                isPublished: deck['isPublished'],

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
              isPublished: deckGroupData['isPublished'],
            );
          }).toList();

          _fetchStatus = PuMocksFetchStatus.success;
        } else {
          _fetchStatus = PuMocksFetchStatus.error;
        }
      } else {
        _fetchStatus = PuMocksFetchStatus.error;
      }
    } catch (e) {
      _fetchStatus = PuMocksFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }

}
