// ignore_for_file: constant_identifier_names, unnecessary_getters_setters, deprecated_member_use, avoid_print

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

  void notify() {
    notifyListeners();
  }

  String _discount = "00%";

  String get discount => _discount;
  set discount(String value) {
    _discount = value;

    notify();
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

        final List<BundleModel> bundleList =
        responseData.map((json) => BundleModel.fromJson(json)).toList();

        _bundleList = bundleList;
        loadingStatus = Status.Success;
        notify();

        result = {
          'status': true,
          'message': 'Data fetched successfully',
        };
        for (final bundle in bundleList) {
          print('Bundle Name: ${bundle.bundleName}');
          print('PurchaseLink URL: ${bundle.purchaseFormLink}');
        }
      }

     else {
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

  Future<void> fetchDiscount() async {
    try {
      final response = await _client.get(
        "https://premedpk-cdn.sgp1.cdn.digitaloceanspaces.com/Mobile-App/discount.json",
      );

      if (response['discount'] != null) {
        _discount = response['discount'];
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }
}
