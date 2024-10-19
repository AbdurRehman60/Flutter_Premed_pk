// ignore_for_file: unnecessary_getters_setters, deprecated_member_use

import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/utils/base64_convertor.dart';

enum CouponValidateStatus { init, success, validating }

enum OrderStatus { init, success, processing, error }

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

  OrderStatus _orderStatus = OrderStatus.init;

  OrderStatus get orderStatus => _orderStatus;

  set orderStatus(OrderStatus value) {
    _orderStatus = value;
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

  Map<String, dynamic> _errors = {
    "hasErrors": false,
    "error": "",
  };

  Map<String, dynamic> get errors => _errors;

  set errors(Map<String, dynamic> value) {
    _errors = value;
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
      total = afterDiscountPrice - couponDiscount;
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

  void resetToDefaults() {
    _selectedBundles.clear();
    _validatingStatus = CouponValidateStatus.init;
    _orderStatus = OrderStatus.init;
    _couponCode = null;
    _couponAmount = null;
    _errors = {
      "hasErrors": false,
      "error": "",
    };
    _uploadedImage = null;

    notify();
  }

  Future<Map<String, dynamic>> placeOrder(String transactionId) async {
    Map<String, Object?> result;

    _orderStatus = OrderStatus.processing;
    notify();

    try {
      final List<String> bundleIds = _selectedBundles.map((b) => b.id).toList();

      final Map<String, dynamic> purchaseData = {
        "username": UserProvider().getEmail(),
        "BundleId": bundleIds,
        "PaymentProof": await imageToDataUri(
            UplaodImageProvider().uploadedImage!, "image/jpeg"),
        "TransactionID": transactionId,
      };

      if (couponCode.isNotEmpty) {
        purchaseData['CouponCode'] = couponCode;
      }

      final response = await _client.post(
        Endpoints.PurchaseBundles,
        data: purchaseData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        result = {
          'status': true,
          'message': responseData['message'],
        };
        resetToDefaults();
      } else {
        _orderStatus = OrderStatus.error;
        notify();
        result = {
          'status': false,
          'message': json.decode(response.data['error']),
        };
      }
    } on DioError catch (e) {
      _orderStatus = OrderStatus.error;
      notify();
      return {
        'status': false,
        'message': e.response!.data['message'],
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> verifyCouponCode(String coupon) async {
    Map<String, Object?> result;

    validatingStatus = CouponValidateStatus.validating;
    notify();

    try {
      // Pass the coupon code correctly into the URL
      final response = await _client.get('${Endpoints.CouponCode(coupon)}');

      // Response is already a parsed map, so access directly
      final data = response as Map<String, dynamic>;

      // Check the 'Error' field in the data map
      if (data['Error'] == false) {
        _couponCode = data['Code'];
        _couponAmount = data['Amount'];

        validatingStatus = CouponValidateStatus.success;
        result = {
          'status': true,
          'message': 'Promo code applied!',
        };
      } else {
        validatingStatus = CouponValidateStatus.init;
        result = {
          'status': false,
          'message': data['ErrorType'], // Handle error message
        };
      }
    } on DioError catch (e) {
      validatingStatus = CouponValidateStatus.init;
      result = {
        'status': false,
        'message': e.message, // Use DioError's message
      };
    }

    notify();
    return result;
  }
}
