import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../api_manager/dio client/dio_client.dart';
import '../../api_manager/dio client/endpoints.dart';
import '../../constants/constants_export.dart';
import '../../models/deck_group_model.dart';

enum DeckFetchStatus { init, fetching, success, error }

class EngTestSessionsPro extends ChangeNotifier {
  DeckFetchStatus _fetchStatus = DeckFetchStatus.init;

  DeckFetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];

  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = DeckFetchStatus.fetching;
      notifyListeners();

      final DioClient dio = DioClient();
      final Response response = await dio.post(Endpoints.PublishedDecks, data: {
        "CategoriesWeWant": ["PreEngineering Test Sessions"]
      });

      final responseData = response.data as Map<String, dynamic>;
      final bool success = responseData['success'] ?? false;

      if (success) {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? engineeringQbankCategory;

        try {
          engineeringQbankCategory = data.firstWhere(
                (category) => category['categoryName'] == 'PreEngineering Test Sessions',
          );
        } catch (e) {
          engineeringQbankCategory = null;
        }

        if (engineeringQbankCategory != null) {
          final List<dynamic> deckGroupsData = engineeringQbankCategory['deckGroups'];

          _deckGroups = deckGroupsData.map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.where((deck) {
              return deck['isPublished'] == true;
            }).map((deck) {
              return DeckItem(
                deckName: deck['deckName'],
                deckLogo: deck['deckLogo'],
                premiumTag: deck['premiumTags'] != null && (deck['premiumTags'] as List).isNotEmpty
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
              // deckNameCount: deckNameCount,
              deckGroupImage: deckGroupImage,
              isPublished: deckGroupData['isPublished'],
            );
          }).where((deckGroup) => deckGroup != null).cast<DeckGroupModel>().toList();

          for (var deckGroup in _deckGroups) {
            for (var deckItem in deckGroup.deckItems) {
              print('Deck Name: ${deckItem.deckName}');
              print('Premium Tags: ${deckItem.premiumTag}');
            }
          }

          _fetchStatus = DeckFetchStatus.success;
        } else {
          _fetchStatus = DeckFetchStatus.error;
        }
      } else {
        _fetchStatus = DeckFetchStatus.error;
      }
    } catch (e) {
      print("Error: $e");
      _fetchStatus = DeckFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
