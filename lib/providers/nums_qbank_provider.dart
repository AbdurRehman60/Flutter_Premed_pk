import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';

enum NumsFetchStatus { init, fetching, success, error }

class NUMSQbankProvider extends ChangeNotifier {
  NumsFetchStatus _fetchStatus = NumsFetchStatus.init;

  NumsFetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];

  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = NumsFetchStatus.fetching;
      notifyListeners();

      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.NUMSQbank);
      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? nums;
        try {
          nums = data.firstWhere(
                (category) => category['categoryName'] == 'NUMS QBank',
          );
        } catch (e) {
          nums = null;
        }

        if (nums != null) {
          final List<dynamic> deckGroupsData = nums['deckGroups'];
          _deckGroups = deckGroupsData
              .where((deckGroupData) => deckGroupData['isPublished'] == true) // Filter out unpublished deck groups
              .map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.map((deck) {
              return DeckItem(
                deckName: deck['deckName'],
                deckLogo: deck['deckLogo'],
                premiumTag: deck['premiumTags'] != null &&
                    (deck['premiumTags'] as List).isNotEmpty
                    ? (deck['premiumTags'][0] as String)
                    : '',
                isPublished: deck['isPublished'],

                deckInstructions: deck['deckInstructions'] ?? '',
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

        _fetchStatus = NumsFetchStatus.success;
        } else {
          _fetchStatus = NumsFetchStatus.error;
        }
      } else {
        _fetchStatus = NumsFetchStatus.error;
      }
    } catch (e) {
      _fetchStatus = NumsFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
