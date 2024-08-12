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
        "CategoriesWeWant": ["Test Sessions"]
      });

      final responseData = response.data as Map<String, dynamic>;
      final bool success = responseData['success'] ?? false;

      if (success) {
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? numsMocksCategory;
        try {
          numsMocksCategory = data.firstWhere(
            (category) => category['categoryName'] == 'Test Sessions',
          );
        } catch (e) {
          numsMocksCategory = null;
        }
        if (numsMocksCategory != null) {
          final List<dynamic> deckGroupsData = numsMocksCategory['deckGroups'];
          _deckGroups = deckGroupsData
              .where((deckGroupData) => deckGroupData['isPublished'] == true)
              .map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks
                .where((deck) => deck['isPublished'] == true)
                .map((deck) => DeckItem.fromJson(deck))
                .toList();
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
