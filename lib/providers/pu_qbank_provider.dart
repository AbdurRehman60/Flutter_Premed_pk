import '../../../api_manager/dio client/dio_client.dart';
import '../../../api_manager/dio client/endpoints.dart';
import '../../../constants/constants_export.dart';
import '../../../models/deck_group_model.dart';

enum PuFetchStatus { init, fetching, success, error }

class PUQbankProvider extends ChangeNotifier {
  PuFetchStatus _fetchStatus = PuFetchStatus.init;

  PuFetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];

  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = PuFetchStatus.fetching;
      notifyListeners();

      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.PRVUQbank);
      final bool success = responseData['success'] ?? false;
      if (success) {
        final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(responseData['data']);
        Map<String, dynamic>? pu;
        try {
          pu = data.firstWhere(
                (category) =>
            category['categoryName'] == 'Private Universities QBank',
          );
        } catch (e) {
          pu = null;
        }

        if (pu != null) {
          final List<dynamic> deckGroupsData = pu['deckGroups'];
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
            // Print

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


          _fetchStatus = PuFetchStatus.success;
        }
        else {
          _fetchStatus = PuFetchStatus.error;
        }
      } else {
        _fetchStatus = PuFetchStatus.error;
      }
    } catch (e) {
      _fetchStatus = PuFetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}