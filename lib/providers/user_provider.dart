import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  factory UserProvider() => _instance;

  UserProvider._internal();
  static final UserProvider _instance = UserProvider._internal();
  final DioClient _client = DioClient();
  void notify() {
    notifyListeners();
  }

  User? _user;
  User? get user => _user;
  set user(User? value) {
    _user = value;
    notify();
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notify();
  }

  String _city = '';
  String get city => _city;
  void setCity(String value) {
    _city = value;
    notify();
  }

  String getUserName() {
    return _user?.fullName ?? '';
  }

  String getEmail() {
    return _user?.userName ?? '';
  }

  int getCoins() {
    return _user?.coins ?? 0;
  }

  // Update full name
  Future<Map<String, dynamic>> updateUserDetails({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? school,
  }) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> updateData = {
      'fullname': fullName,
      'phonenumber': phoneNumber,
      'city': city,
      'school': school,
    };

    try {
      final Response response = await _client.post(
        Endpoints.UpdateAccount,
        data: updateData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        if (responseData['Error'] == false) {
          // Update local user information if needed
          if (fullName != null && _user?.fullName != null) {
            _user!.fullName = fullName;
          }
          if (phoneNumber != null) {
            _phoneNumber = phoneNumber;
          }
          if (city != null) {
            _city = city;
          }
          if (school != null && _user != null) {
            _user!.school = school;
          }

          notify();
          result = {
            'status': true,
            'message': 'User details updated successfully',
          };
        } else {
          result = {
            'status': false,
            'message': 'Failed to update user details',
          };
        }
      } else {
        result = {
          'status': false,
          'message': 'Failed to update user details. Server error.',
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': 'Network error updating user details: ${e.message}',
      };
    }

    notify();
    return result;
  }
}
