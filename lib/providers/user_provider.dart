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

  String getBundle() {
    final bundle = _user?.bundlesPurchased;
    if (bundle != null) {
      print('bundlesPurchased: $bundle');
      return bundle;
    } else {
      print('bundlesPurchased is empty');
      return '';
    }
  }


  // Update full name
  Future<Map<String, dynamic>> updateUserDetails(
      String fullname,
      String email,
      String phoneNumber,
      String city,
      String school,
      ) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> updateData = {
      'fullname': fullname.isEmpty ? user?.fullName : fullname,
      'email' : email.isNotEmpty ? email : user?.userName,
      'phonenumber': phoneNumber.isNotEmpty ? phoneNumber : user?.phoneNumber,
      'city': city.isNotEmpty ? city : user?.city,
      'school': school.isNotEmpty ? school : user?.school,
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

  Future<Map<String, dynamic>> changePassword(
      String oldpassword, String newpassword) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> updateData = {
      'oldpassword': oldpassword,
      'newpassword': newpassword
    };

    try {
      final Response response = await _client.post(
        Endpoints.UpdatePassword,
        data: updateData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);

        if (responseData['Error'] == false) {
          notify();
          result = {
            'status': true,
            'message': 'Password updated successfully',
          };
        } else {
          result = {
            'status': false,
            'message': responseData['ErrorText'],
          };
        }
      } else {
        result = {
          'status': false,
          'message': 'Failed to changed password. Server error.',
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

  //account deletion
  Future<Map<String, dynamic>> deleteAccount(
      String username, String password) async {
    Map<String, dynamic> result;
    try {
      final Response response = await _client.put(
        Endpoints.DeleteAccount,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);

        if (responseData['message'] == "User deleted successfully") {
          notify();
          result = {
            'status': true,
            'message': 'User account deleted successfully',
          };
        } else {
          result = {
            'status': false,
            'message': 'Failed to delete user account',
          };
        }
      } else {
        result = {
          'status': false,
          'message': 'Failed to delete user account. Server error.',
        };
      }
    } on DioException catch (e) {
      result = {
        'status': false,
        'message': 'Network error deleting user account: ${e.message}',
      };
    }

    notify();
    return result;
  }
}
