import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';
import '../api_manager/dio client/dio_client.dart';

enum MdcatFetchStatus { init, fetching, success, error }

class MDCATQbankpro extends ChangeNotifier {
  MdcatFetchStatus _fetchStatus = MdcatFetchStatus.init;
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
        print("Response: $responseData");

        final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? mdcat;

        try {
          mdcat = data.firstWhere(
                  (category) => category['categoryName'] == 'MDCAT QBank');
        } catch (e) {
          print("Error finding MDCAT QBank category: $e");
          mdcat = null;
        }

        if (mdcat != null) {
          final List<dynamic> deckGroupsData = mdcat['deckGroups'];
          _deckGroups = deckGroupsData.map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.where((deck) {
              return deck['isPublished'] == true;
            }).map((deck) {
              final List<dynamic>? premiumTagsJson = deck['premiumTags'] as List<dynamic>?;
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
            if (deckItems.isEmpty || !deckGroupData['isPublished']) {
              return null;
            }

            final String? deckGroupImage = deckGroupData['deckGroupImage'];

            return DeckGroupModel(
              deckType: deckGroupData['deckType'],
              deckGroupName: deckGroupData['deckGroupName'],
              deckItems: deckItems,
              deckGroupImage: deckGroupImage,
              isPublished: deckGroupData['isPublished'],
            );
          }).where((deckGroup) => deckGroup != null).cast<DeckGroupModel>().toList();

          _fetchStatus = MdcatFetchStatus.success;
        } else {
          print("MDCAT QBank category not found in the response.");
          _fetchStatus = MdcatFetchStatus.error;
        }
      } else {
        print("API response indicates failure.");
        _fetchStatus = MdcatFetchStatus.error;
      }
    } catch (e) {
      print('Error fetching deck groups: $e');
      _fetchStatus = MdcatFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
