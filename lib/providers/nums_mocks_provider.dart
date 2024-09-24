import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/dio_client.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';

import '../api_manager/dio client/endpoints.dart';

enum NumsMockFetchStatus { init, fetching, success, error }

class NumsMocksProvider extends ChangeNotifier {
  NumsMockFetchStatus _fetchStatus = NumsMockFetchStatus.init;

  NumsMockFetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];

  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = NumsMockFetchStatus.fetching;
      notifyListeners();
      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.Nums);
      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? numsMocksCategory;
        try {
          numsMocksCategory = data.firstWhere(
                (category) => category['categoryName'] == 'NUMS Mocks',
          );
        } catch (e) {
          numsMocksCategory = null;
        }
        if (numsMocksCategory != null) {
          final List<dynamic> deckGroupsData = numsMocksCategory['deckGroups'];
          _deckGroups = deckGroupsData.map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.where((deck) {
              return deck['isPublished'] == true;
            }).map((deck) {
              return DeckItem(
                deckName: deck['deckName'],
                deckLogo: deck['deckLogo'],
                premiumTag: deck['premiumTags'] != null &&
                    (deck['premiumTags'] as List).isNotEmpty
                    ? (deck['premiumTags'][0] as String)
                    : null,
                deckInstructions: deck['deckInstructions'] ?? '',
                isTutorModeFree: deck['isTutorModeFree'],
                timedTestMode: deck['timedTestMode'],
                timesTestminutes: deck['timedTestMinutes'],
                isPublished: deck['isPublished'],

              );
            }).toList();

            if (deckItems.isEmpty || !deckGroupData['isPublished']) {
              return null;
            }

            final int deckNameCount = deckItems.length;
            final String? deckGroupImage = deckGroupData['deckGroupImage'];

            return DeckGroupModel(
              deckType: deckGroupData['deckType'],
              deckGroupName: deckGroupData['deckGroupName'],
              deckItems: deckItems,
              deckNameCount: deckNameCount,
              deckGroupImage: deckGroupImage,
              isPublished: deckGroupData['isPublished'],
            );
          }).where((deckGroup) => deckGroup != null).cast<DeckGroupModel>().toList();

          _fetchStatus = NumsMockFetchStatus.success;
        } else {
          _fetchStatus = NumsMockFetchStatus.error;
        }
      } else {
        _fetchStatus = NumsMockFetchStatus.error;
      }
    } catch (e) {
      _fetchStatus = NumsMockFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}