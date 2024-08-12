import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/deck_group_model.dart';

import '../../api_manager/dio client/dio_client.dart';

enum ChapterWiseFetchStatus { init, fetching, success, error }

class EngChapterWisePro extends ChangeNotifier {
  ChapterWiseFetchStatus _fetchStatus = ChapterWiseFetchStatus.init;

  ChapterWiseFetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];

  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = ChapterWiseFetchStatus.fetching;
      notifyListeners();
      final DioClient dio = DioClient();
      final Response response = await dio.post(Endpoints.PublishedDecks, data: {
        "CategoriesWeWant": ["Engineering QBank"]
      });

      final responseData = response.data as Map<String, dynamic>;
      final bool success = responseData['success'] ?? false;

      if (success) {
        final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? numsMocksCategory;
        try {
          numsMocksCategory = data.firstWhere(
                (category) => category['categoryName'] == 'Engineering QBank',
          );
        } catch (e) {
          numsMocksCategory = null;
        }
        if (numsMocksCategory != null) {
          final List<dynamic> deckGroupsData = numsMocksCategory['deckGroups'];
          _deckGroups = deckGroupsData
              .where((deckGroupData) =>
          deckGroupData['deckGroupName'] != 'Biology')
              .map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.map((deck) {
              return DeckItem.fromJson(deck);
            }).toList();
            final int deckNameCount = deckItems.length;
            final String deckGroupImage = deckGroupData['deckGroupImage'];
            return DeckGroupModel(
              deckType: deckGroupData['deckType'],
              deckGroupName: deckGroupData['deckGroupName'],
              deckItems: deckItems,
              deckNameCount: deckNameCount,
              deckGroupImage: deckGroupImage,
              isPublished: deckGroupData['isPublished'] ?? false,
            );
          }).toList();

          _fetchStatus = ChapterWiseFetchStatus.success;
        } else {
          _fetchStatus = ChapterWiseFetchStatus.error;
        }
      } else {
        _fetchStatus = ChapterWiseFetchStatus.error;
      }
    } catch (e) {
      print("Error: $e");
      _fetchStatus = ChapterWiseFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
