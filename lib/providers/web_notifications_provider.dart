// ignore_for_file: constant_identifier_names, unnecessary_getters_setters

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';

import 'package:premedpk_mobile_app/models/web_notification_model.dart';

enum Status {
  Init,
  Fetching,
  Success,
}

class WebNotificationsProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _notificationStatus = Status.Init;
  Status get notificationStatus => _notificationStatus;
  set notificationStatus(Status value) {
    _notificationStatus = value;
  }

  List<WebNotificationModel> _webNotificationList = [];
  List<WebNotificationModel> get webNotificationList => _webNotificationList;
  set webNotificationList(List<WebNotificationModel> value) {
    _webNotificationList = value;
  }

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchNotifications() async {
    Map<String, Object?> result;
    _notificationStatus = Status.Fetching;

    if (webNotificationList.isNotEmpty) {
      notify();
    }
    try {
      final response = await _client.get(
        Endpoints.GetWebNotifications,
      );
      final List<WebNotificationModel> list = [];
      for (final data in response) {
        final WebNotificationModel fetchedData =
            WebNotificationModel.fromJson(data);
        list.add(fetchedData);
      }

      webNotificationList = list;
      _notificationStatus = Status.Success;
      result = {
        'status': true,
        'message': 'Data fetched successfully',
      };
    } on DioException catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }
    _notificationStatus = Status.Init;
    notify();
    return result;
  }
}
