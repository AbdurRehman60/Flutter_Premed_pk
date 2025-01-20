import '../../api_manager/dio client/dio_client.dart';
import '../../api_manager/dio client/endpoints.dart';
import '../../constants/constants_export.dart';
import '../../models/deck_group_model.dart';

enum DeckFetchStatus { init, fetching, success, error }

class MedTestSessionsPro extends ChangeNotifier {
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
        "CategoriesWeWant": ["Test Sessions"]      });

      final responseData = response.data as Map<String, dynamic>;
      final bool success = responseData['success'] ?? false;

      if (success) {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? engineeringQbankCategory;

        try {
          engineeringQbankCategory = data.firstWhere(
                (category) => category['categoryName'] == 'Test Sessions',
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

          for (final deckGroup in _deckGroups) {
            for (final deckItem in deckGroup.deckItems) {
              print('Deck Name: ${deckItem.deckName}');
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
