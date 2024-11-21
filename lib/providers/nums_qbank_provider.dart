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
              .where((deckGroupData) => deckGroupData['isPublished'] == true)
              .map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.map((deck) {
              final List<dynamic>? premiumTagsJson = deck['premiumTags'] as List<dynamic>?;

              // Join for display/logging, but keep as a list for actual use
              final List<String> premiumTags = premiumTagsJson != null
                  ? premiumTagsJson.map((tag) => tag.toString()).toList()
                  : [];
              print('Raw Premium Tags: $premiumTags');

              return DeckItem(
                deckName: deck['deckName'],
                deckLogo: deck['deckLogo'],
                premiumTags: premiumTags,
                deckInstructions: deck['deckInstructions'] ?? '',
                isTutorModeFree: deck['isTutorModeFree'] ?? false,
                timedTestMode: deck['timedTestMode'] ?? false,
                timesTestminutes: deck['timedTestMinutes'] ?? 0,
                isPublished: deck['isPublished'],
              );
            }).toList();


            final int deckNameCount = deckItems.length;
            final String deckGroupImage = deckGroupData['deckGroupImage'];
            return DeckGroupModel(
              deckType: deckGroupData['deckType'],
              deckGroupName: deckGroupData['deckGroupName'],
              deckItems: deckItems,
             // deckNameCount: deckNameCount,
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
