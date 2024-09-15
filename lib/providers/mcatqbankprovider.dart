import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';

import '../api_manager/dio client/dio_client.dart';

enum MdcatFetchStatus { init, fetching, success, error }

class MDCATQbankpro extends ChangeNotifier {
  MdcatFetchStatus _fetchStatus =  MdcatFetchStatus.init;
  MdcatFetchStatus get fetchStatus => _fetchStatus;
  List<DeckGroupModel> _deckGroups = [];
  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = MdcatFetchStatus.fetching;
      notifyListeners();
      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.MdcatQbank);

      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? mdcat;
        try {
          mdcat = data.firstWhere(
                (category) => category['categoryName'] == 'MDCAT QBank',
          );
        } catch (e) {
          mdcat = null;
        }

        if (mdcat != null) {
          final List<dynamic> deckGroupsData = mdcat['deckGroups'];
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
                isPublished: deck['isPublished'],
                deckInstructions: deck['deckInstructions'] ?? '',
                isTutorModeFree: deck['isTutorModeFree'],
                timedTestMode: deck['timedTestMode'],
                timesTestminutes: deck['timedTestMinutes'],
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

          _fetchStatus = MdcatFetchStatus.success;
        } else {
          _fetchStatus = MdcatFetchStatus.error;
        }
      } else {
        _fetchStatus = MdcatFetchStatus.error;
      }
    } catch (e) {
      _fetchStatus = MdcatFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
