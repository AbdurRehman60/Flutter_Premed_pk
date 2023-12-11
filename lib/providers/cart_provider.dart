// ignore_for_file: unnecessary_getters_setters, deprecated_member_use

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';

enum CouponValidateStatus { init, success, validating }

class CartProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  void notify() {
    notifyListeners();
  }

  final List<BundleModel> _selectedBundles = [];

  CouponValidateStatus _validatingStatus = CouponValidateStatus.init;

  CouponValidateStatus get validatingStatus => _validatingStatus;

  set validatingStatus(CouponValidateStatus value) {
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
    for (final bundle in _selectedBundles) {
      total += bundle.bundlePrice;
    }
    return total;
  }

  double get afterDiscountPrice {
    double total = 0;
    for (final bundle in _selectedBundles) {
      total += bundle.bundlePrice - bundle.bundleDiscount;
    }

    return total;
  }

  double get couponDiscount {
    double total = 0;
    for (final _ in _selectedBundles) {
      total = afterDiscountPrice * couponAmount;
    }
    return total;
  }

  double get calculateTotalDiscount {
    double total = 0;
    for (final _ in _selectedBundles) {
      total = afterDiscountPrice + couponDiscount;
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

  File? _uploadedImage;
  File? get uploadedImage => _uploadedImage;
  set uploadedImage(File? value) {
    _uploadedImage = value;
    notify();
  }

  Future<Map<String, dynamic>> placeOrder() async {
    try {
      final List<String> bundleIds = _selectedBundles.map((b) => b.id).toList();

      final Map<String, dynamic> purchaseData = {
        "username": UserProvider().getEmail(),
        "BundleId": bundleIds,
        "PaymentProof":
            "imageToDataUri(UplaodImageProvider().uploadedImage!, " ")",
        "CouponCode": couponCode,
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
    Map<String, Object?> result;

    validatingStatus = CouponValidateStatus.validating;
    notify();
    try {
      final response = await _client.get('${Endpoints.CouponCode}/$coupon');

      if (response['Error'] == false) {
        _couponCode = response['Code'];
        _couponAmount = response['Amount'];

        validatingStatus = CouponValidateStatus.success;
        result = {
          'status': true,
          'message': 'Promo code applied!',
        };
        notify();
      } else {
        validatingStatus = CouponValidateStatus.init;
        notify();
        result = {
          'status': false,
          'message': response['ErrorType'],
        };
      }
    } on DioError catch (e) {
      validatingStatus = CouponValidateStatus.init;
      notify();
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }
}
