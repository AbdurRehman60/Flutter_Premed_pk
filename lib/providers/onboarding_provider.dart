import '../constants/constants_export.dart';
import '../models/boards_and_features_model.dart';

class BoardProvider with ChangeNotifier {
  List<Board> _boards = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Board> get boards => _boards;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final Dio _dio = Dio();
  final String _url = "https://app.premed.pk/api/packages/get-boards-and-features";

  Future<void> fetchBoards() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final boardsResponse = BoardsResponse.fromJson(response.data);
        _boards = boardsResponse.boards;
      } else {
        _errorMessage = 'Failed to load boards: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
