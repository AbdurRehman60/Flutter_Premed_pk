import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/recent_activity_model.dart';

import '../constants/constants_export.dart';

enum RecentActivityStatus { Init, Fetching, Success, Error }

class RecentActivityProvider extends ChangeNotifier {
  final DioClient _client = DioClient();
  final String recentActivityEndpoint = Endpoints.serverURL + Endpoints.RecentActivityURL;

  RecentActivityStatus _loadingStatus = RecentActivityStatus.Init;
  RecentActivityStatus get loadingStatus => _loadingStatus;
  set loadingStatus(RecentActivityStatus value) {
    _loadingStatus = value;
  }

  void notify() {
    notifyListeners();
  }

  List<RecentActivityModel> _recentActivityList = [];

  List<RecentActivityModel> get recentActivityList => _recentActivityList;
  set recentActivityList(List<RecentActivityModel> value) {
    _recentActivityList = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchRecentActivity() async {
    Map<String, dynamic> result;
    _loadingStatus = RecentActivityStatus.Fetching;

    try {
      final response = await _client.post(
        recentActivityEndpoint,
        data: {"userId": '64c68bc9f093d0bd25c026de'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);
        if (responseData["success"]) {
          final List<dynamic> activityData = responseData["Result"];
          _recentActivityList = activityData
              .map((data) => RecentActivityModel.fromJson(data))
              .toList();
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
        _loadingStatus = RecentActivityStatus.Error;
        notify();
        result = {'status': false, 'message': 'Request failed'};
      }
    } on DioError catch (e) {
      _loadingStatus = RecentActivityStatus.Error;
      notify();
      result = {
        'status': false,
        'message': e.response?.data['message'],
      };
    }
    return result;
  }
}
