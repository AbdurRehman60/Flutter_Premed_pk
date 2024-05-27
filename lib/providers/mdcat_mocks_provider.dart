import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/dio_client.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';
import '../api_manager/dio client/endpoints.dart';

enum FetchStatus { init, fetching, success, error }

class MdcatMocksProvider extends ChangeNotifier {
  FetchStatus _fetchStatus = FetchStatus.init;

  FetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];

  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = FetchStatus.fetching;
      notifyListeners();
      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.Deckspoints);
      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? mdcatMocksCategory;
        try {
          mdcatMocksCategory = data.firstWhere(
            (category) => category['categoryName'] == 'MDCAT Mocks',
          );
        } catch (e) {
          mdcatMocksCategory = null;
        }
        if (mdcatMocksCategory != null) {
          final List<dynamic> deckGroupsData = mdcatMocksCategory['deckGroups'];
          _deckGroups = deckGroupsData.map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.map((deck) {
              return DeckItem(
                  deckName: deck['deckName'] as String,
                  deckLogo: deck['deckLogo'] as String,
                  premiumTag: deck['premiumTags'][0] as String,
                  deckInstructions: deck['deckInstructions'] as String);
            }).toList();
            final int deckNameCount = deckItems.length;
            final String deckGroupImage = deckGroupData['deckGroupImage'];
            return DeckGroupModel(
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
