import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import this for ChangeNotifier
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/export.dart';
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

  Future<Map<String, dynamic>> fetchBundles() async {
    var result;
    _loadingStatus = Status.Fetching;
    notify();

    try {
      final response = await _client.get(
        Endpoints.GetBundles,
      );

      if (response == '') {
        final List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(response['data']);

        // Directly map to BundleModel
        List<BundleModel> bundleList =
            responseData.map((json) => BundleModel.fromJson(json)).toList();

        notify();
        print(responseData);

        result = {
          'status': true,
          'message': 'Data fetched successfully',
        };
      } else {
        print('Failed to load data: ${response}');
        result = {
          'status': false,
          'message': 'Failed to fetch data',
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }

    _loadingStatus = Status.Init;
    notify();

    return result;
  }
}
