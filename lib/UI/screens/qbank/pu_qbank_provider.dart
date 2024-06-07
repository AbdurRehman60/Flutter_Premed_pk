import '../../../api_manager/dio client/dio_client.dart';
import '../../../api_manager/dio client/endpoints.dart';
import '../../../constants/constants_export.dart';
import '../../../models/deck_group_model.dart';

enum FetchStatus { init, fetching, success, error }

class PUQbankProvider extends ChangeNotifier {
  FetchStatus _fetchStatus = FetchStatus.init;

  FetchStatus get fetchStatus => _fetchStatus;

  List<DeckGroupModel> _deckGroups = [];

  List<DeckGroupModel> get deckGroups => _deckGroups;

  Future<void> fetchDeckGroups() async {
    try {
      _fetchStatus = FetchStatus.fetching;
      notifyListeners();

      final DioClient dio = DioClient();
      final responseData = await dio.get(Endpoints.PRVUQbank);
      print(
          'Response Data: $responseData'); // Print response data for debugging

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
          _deckGroups = deckGroupsData.map((deckGroupData) {
            final List<dynamic> decks = deckGroupData['decks'];
            final List<DeckItem> deckItems = decks.map((deck) {
              print('Deck Data: $deck');
              return DeckItem(
                deckName: deck['deckName'],
                deckLogo: deck['deckLogo'],
                premiumTag: deck['premiumTags'] != null &&
                        (deck['premiumTags'] as List).isNotEmpty
                    ? (deck['premiumTags'][0] as String)
                    : '1', // Handle possible null or empty list
                deckInstructions: deck['deckInstructions'] ?? '',
              );
            }).toList();

            print('Deck Items: $deckItems'); // Print

            final int deckNameCount = deckItems.length;
            final String deckGroupImage = deckGroupData['deckGroupImage'];
            return DeckGroupModel(
              deckType: deckGroupData['deckType'],
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
      print('Error: $e'); // Print error for debugging
      _fetchStatus = FetchStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
