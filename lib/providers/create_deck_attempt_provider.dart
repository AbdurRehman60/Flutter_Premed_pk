
import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import '../constants/constants_export.dart';
import '../models/create_deck_attemot_model.dart';

class CreateDeckAttemptProvider extends ChangeNotifier {
  factory CreateDeckAttemptProvider() => _instance;

  CreateDeckAttemptProvider._internal();
  static final CreateDeckAttemptProvider _instance = CreateDeckAttemptProvider._internal();
  final DioClient _client = DioClient();

  String? _responseMessage;
  String attemptId = '';
  String? get responseMessage => _responseMessage;

  Future<void> createDeckAttempt(CreateDeckAttemptModel attemptModel) async {
    try {
      if (attemptModel.user.isEmpty) {
        throw Exception('User cannot be null or empty');
      }

      // print('Creating deck attempt with user: ${attemptModel.user}');

      final response = await _client.post(
        Endpoints.DeckAttempt,
        data: attemptModel.toJson(),
      );

      if (response.statusCode == 200) {
        // print("this is the attempt id made $response");
        _responseMessage = 'Attempt created successfully';
        attemptId = response.data['attemptId'];
      } else {
        _responseMessage = 'Failed to create attempt: ${response.statusCode}';
      }
    } catch (e) {
      _responseMessage = 'Error creating attempt: $e';
    }
    notifyListeners();
  }
}
