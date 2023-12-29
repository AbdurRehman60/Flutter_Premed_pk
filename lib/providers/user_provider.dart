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
  Future<void> updateFullName(String fullName) async {
    try {
      final response = await _client.post(
        Endpoints.UpdateAccount,
        data: {
          'fullname': fullName,
        },
      );

      // Check the response and handle accordingly
      if (response.data['Error'] == false) {
        // Update local user information if needed
        // For example, update the _user property
        _user?.fullName = fullName;
        notify();
      } else {
        // Handle error
        print('Error updating full name: ${response.data}');
      }
    } catch (error) {
      // Handle network error
      print('Network error updating full name: $error');
    }
  }

  // Update phone number
  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      final response = await _client.post(
        Endpoints.UpdateAccount,
        data: {
          'phonenumber': phoneNumber,
        },
      );

      if (response.data['Error'] == false) {
        // Update local user information if needed
        _phoneNumber = phoneNumber;
        notify();
      } else {
        // Handle error
        print('Error updating phone number: ${response.data}');
      }
    } catch (error) {
      // Handle network error
      print('Network error updating phone number: $error');
    }
  }

  // Update city
  Future<void> updateCity(String city) async {
    try {
      final response = await _client.post(
        Endpoints.UpdateAccount,
        data: {
          'city': city,
        },
      );

      if (response.data['Error'] == false) {
        // Update local user information if needed
        _city = city;
        notify();
      } else {
        // Handle error
        print('Error updating city: ${response.data}');
      }
    } catch (error) {
      // Handle network error
      print('Network error updating city: $error');
    }
  }

  // Update password
  // Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      final response = await _client.post(
        Endpoints.UpdateAccount,
        data: {
          'password': newPassword,
        },
      );

      if (response.data['Error'] == false) {
        // Password updated successfully
      } else {
        // Handle error and print response details
        print('Error updating password: ${response.data}');
      }
    } catch (error) {
      // Handle network error
      print('Network error updating password: $error');
    }
  }
}
