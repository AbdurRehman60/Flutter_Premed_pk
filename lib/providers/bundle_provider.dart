// ignore_for_file: constant_identifier_names, unnecessary_getters_setters, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';

enum Status {
  Init,
  Fetching,
  Success,
}

class BundleProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _loadingStatus = Status.Init;
  Status get loadingStatus => _loadingStatus;
  set loadingStatus(Status value) {
    _loadingStatus = value;
  }

  notify() {
    notifyListeners();
  }

  List<BundleModel> _bundleList = [];
  List<BundleModel> get bundleList => _bundleList;
  set bundleList(List<BundleModel> value) {
    _bundleList = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchBundles() async {
    Map<String, Object?> result;
    _loadingStatus = Status.Fetching;

    try {
      final response = await _client.get(
        Endpoints.GetBundles,
      );

      if (response['data'] != null) {
        final List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(response['data']);

        List<BundleModel> bundleList =
            responseData.map((json) => BundleModel.fromJson(json)).toList();

        _bundleList = bundleList;
        loadingStatus = Status.Success;
        notify();

        result = {
          'status': true,
          'message': 'Data fetched successfully',
        };
      } else {
        _loadingStatus = Status.Init;
        notify();
        result = {
          'status': false,
          'message': 'Failed to fetch data',
        };
      }
    } on DioError catch (e) {
      _loadingStatus = Status.Init;
      notify();
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }
}
