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
  String? _couponCode;
  double? _couponAmount;
  String get couponCode => _couponCode ?? "";
  double get couponAmount => _couponAmount ?? 0;

  notify() {
    notifyListeners();
  }

  List<BundleModel> get selectedBundles => _selectedBundles;

  // Add properties for tracking total amounts
  double get afterDiscountPrice {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total += (bundle.bundlePrice - bundle.bundleDiscount);
    }
    notify();
    return total;
  }

  double get totalOriginalPrice {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total += bundle.bundlePrice;
    }
    return total;
  }

  double get coupounDiscount {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total += (afterDiscountPrice * couponAmount);
    }
    return total;
  }

  double get calculateTotalDiscount {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total = (afterDiscountPrice - coupounDiscount);
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

  Future<Map<String, dynamic>> placeOrder(
    String username,
  ) async {
    try {
      List<String> bundleIds = _selectedBundles.map((b) => b.id).toList();

      Map<String, dynamic> purchaseData = {
        "username": "ddd@gmail.com",
        "BundleId": bundleIds,
        "PaymentProof": "",
        "ReferralCode": "",
      };
      // if (ReferralCode != null && ReferralCode.isNotEmpty) {
      //   purchaseData["referralCode"] = ReferralCode;
      // }
      notify();
      print('Saad');
      // Call the API function from DioClient
      final response = await _client.post(
        Endpoints.PurchaseBundles,
        data: purchaseData,
      );

      if (response == 'Bundle Purchased Successfully') {
        // API request successful
        final responseData = response.data;
        print(responseData);
        // Extract information from the response
        final message = responseData['message'];
        final orderData = responseData['order'];
        // Extract additional information as needed

        // Use the extracted information as needed
        print('Message: $message');
        print('Order Data: $orderData');

        // You may want to update the local state or take further actions based on the response

        // Notify listeners to update the UI
        notify();

        // Return some data or a default value
        return {
          'status': true,
          'message': 'Order placed successfully',
          'data':
              responseData, // You can adjust this based on what you want to return
        };
      } else {
        // API request failed
        print(
            'Failed to send data to API. Status code: ${response.statusCode}');
        // Handle the error, e.g., show an error message

        // Return an error status
        return {
          'status': false,
          'message': 'Failed to place the order',
        };
      }
    } on DioError catch (e) {
      // Handle DioError
      print('DioError: ${e.message}');

      // Return an error status
      return {
        'status': false,
        'message': e.message,
      };
    }
  }

  Future<Map<String, dynamic>> verifyCouponCode(String coupon) async {
    var result;
    try {
      final response = await _client.get('${Endpoints.CouponCode}/$coupon');

      if (response['Error'] == false) {
        _couponCode = response['Code'];
        _couponAmount = response['Amount'];
        result = {
          'status': true,
          'message': 'Promo code applied!',
        };
        notify();
      } else {
        result = {
          'status': false,
          'message': response['ErrorType'],
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }
}
