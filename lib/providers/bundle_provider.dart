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
  final DioClient _client = DioClient();
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

  double get calculateTotalDiscount {
    double totalDiscount = 0;
    for (var bundle in _selectedBundles) {
      totalDiscount += (bundle.bundlePrice - bundle.bundleDiscount);
    }
    return totalDiscount;
  }

  int get totalBundlesCount {
    return _selectedBundles.length;
  }

  void addToCart(BundleModel bundle) {
    _selectedBundles.add(bundle);
    notifyListeners();
  }

  Future<void> PurchaseBundles(Map<String, dynamic> payload) async {
    try {
      final response = await _client.post(
        Endpoints.PurchaseBundles,
        data: payload,
      );

      if (response.statusCode == 200) {
        // API request successful
        final responseData = response.data;

        // Extract information from the response
        final username = responseData['username'];
        final bundleId = responseData['BundleId'][0]; // Assuming it's a list
        final paymentProof = responseData['PaymentProof'];
        final referral = responseData['Referral'];

        // Use the extracted information as needed
        print('Username: $username');
        print('BundleId: $bundleId');
        print('PaymentProof: $paymentProof');
        print('Referral: $referral');

        // You may want to update the local state or take further actions based on the response
      } else {
        // API request failed
        print(
            'Failed to send data to API. Status code: ${response.statusCode}');
        // Handle the error, e.g., show an error message
      }
    } catch (error) {
      // Handle network errors
      print('Error sending data to API: $error');
      // Handle the error, e.g., show an error message
    }
  }

  Future<void> placeOrder() async {
    try {
      // Prepare payload for API request
      List<String> bundleIds = _selectedBundles.map((b) => b.id).toList();
      Map<String, dynamic> payload = {
        "username": "ddd@gmail.com",
        "BundleId": bundleIds,
        "PaymentProof": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAA",
        "Referral": " ",
      };

      // Call the API function from DioClient
      await PurchaseBundles(payload);

      // Optionally, you can perform additional actions after a successful order placement

      // Notify listeners to update the UI
      notifyListeners();
    } catch (error) {
      // Handle errors, e.g., show an error message
      print('Error placing order: $error');
    }
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
