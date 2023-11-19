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

  List<BundleModel> _bundleList = [];
  List<BundleModel> get bundleList => _bundleList;
  set bundleList(List<BundleModel> value) {
    _bundleList = value;
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

      if (response['data'] != null) {
        // Change this line
        final List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(response['data']);

        // Directly map to BundleModel
        List<BundleModel> bundleList =
            responseData.map((json) => BundleModel.fromJson(json)).toList();

        // Set the bundleList property
        _bundleList = bundleList;

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

class CartProvider extends ChangeNotifier {
  List<BundleModel> _selectedBundles = [];

  List<BundleModel> get selectedBundles => _selectedBundles;

  // Add properties for tracking total amounts
  double get totalDiscountedPrice {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total += bundle.bundleDiscount;
    }
    return total;
  }

  double get totalOriginalPrice {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total += bundle.bundlePrice;
    }
    return total;
  }

  int get totalBundlesCount {
    return _selectedBundles.length;
  }

  void addToCart(BundleModel bundle) {
    _selectedBundles.add(bundle);
    notifyListeners();
  }

  void removeFromCart(BundleModel bundle) {
    _selectedBundles.remove(bundle);
    notifyListeners();
  }

  void clearCart() {
    _selectedBundles.clear();
    notifyListeners();
  }
}
