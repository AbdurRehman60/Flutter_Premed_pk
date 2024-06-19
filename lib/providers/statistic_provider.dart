import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';

enum UserStatStatus { Init, Fetching, Success, Error }

class UserStatProvider extends ChangeNotifier {
  final DioClient _client = DioClient();
  final String statsEndpoint = Endpoints.serverURL + Endpoints.UserStatistics;

  UserStatStatus _loadingStatus = UserStatStatus.Init;
  UserStatStatus get loadingStatus => _loadingStatus;
  set loadingStatus(UserStatStatus value) {
    _loadingStatus = value;
  }

  void notify() {
    notifyListeners();
  }

  UserStatModel? _userStatModel;

  UserStatModel? get userStatModel => _userStatModel;
  set userStatModel(UserStatModel? value) {
    _userStatModel = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchUserStatistics() async {
    Map<String, dynamic> result;
    _loadingStatus = UserStatStatus.Fetching;

    try {
      // print('fetching');
      final Response response = await _client.post(
        statsEndpoint,
        data: {"userId": '64c68bc9f093d0bd25c026de'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        if (responseData["success"]) {
          final Map<String, dynamic> json = responseData["return"];
          _userStatModel = UserStatModel.fromJson(json);
          notify();
          result = {
            'status': true,
            'message': responseData["message"],
          };
        } else {
          result = {
            'status': false,
            'message': responseData["message"],
          };
        }
      } else {
        _loadingStatus = UserStatStatus.Error;
        notify();
        result = {'status': false, 'message': 'Request failed'};
      }
    } on DioError catch (e) {
      _loadingStatus = UserStatStatus.Error;
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    return result;
  }
}
