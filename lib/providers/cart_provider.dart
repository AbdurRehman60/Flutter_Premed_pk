import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';

enum ValidateStatus { init, success, validating }

class CartProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  notify() {
    notifyListeners();
  }

  final List<BundleModel> _selectedBundles = [];

  ValidateStatus _validatingStatus = ValidateStatus.init;

  ValidateStatus get validatingStatus => _validatingStatus;

  set validatingStatus(ValidateStatus value) {
    _validatingStatus = value;
  }

  String? _couponCode;
  String get couponCode => _couponCode ?? "";
  set couponCode(String value) {
    _couponCode = value;
  }

  double? _couponAmount;
  double get couponAmount => _couponAmount ?? 0;
  set couponAmount(double value) {
    _couponAmount = value;
  }

  List<BundleModel> get selectedBundles => _selectedBundles;

  double get totalOriginalPrice {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total += bundle.bundlePrice;
    }
    return total;
  }

  double get afterDiscountPrice {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total += (bundle.bundlePrice - bundle.bundleDiscount);
    }

    return total;
  }

  double get coupounDiscount {
    double total = 0;
    for (var bundle in _selectedBundles) {
      total = (afterDiscountPrice * couponAmount);
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
    notify();
  }

  void removeFromCart(BundleModel bundle) {
    _selectedBundles.remove(bundle);
    notify();
  }

  void clearCart() {
    _selectedBundles.clear();
    notify();
  }

  void clearCoupon() {
    _couponCode = null;
    _couponAmount = null;
    notify();
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

    validatingStatus = ValidateStatus.validating;
    notify();
    try {
      final response = await _client.get('${Endpoints.CouponCode}/$coupon');

      if (response['Error'] == false) {
        _couponCode = response['Code'];
        _couponAmount = response['Amount'];

        validatingStatus = ValidateStatus.success;
        result = {
          'status': true,
          'message': 'Promo code applied!',
        };
        notify();
      } else {
        validatingStatus = ValidateStatus.init;
        notify();
        result = {
          'status': false,
          'message': response['ErrorType'],
        };
      }
    } on DioError catch (e) {
      validatingStatus = ValidateStatus.init;
      notify();
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }
}
