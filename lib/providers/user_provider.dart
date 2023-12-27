import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  factory UserProvider() => _instance;

  UserProvider._internal();
  static final UserProvider _instance = UserProvider._internal();

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
}
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:premedpk_mobile_app/models/user_model.dart';

// class UserProvider extends ChangeNotifier {
//   factory UserProvider(Dio dioClient) {
//     if (_instance == null) {
//       _instance = UserProvider._internal(dioClient);
//     }
//     return _instance!;
//   }

//   UserProvider._internal(this.dioClient);

//   static UserProvider? _instance;

//   Dio dioClient;

//   void notify() {
//     notifyListeners();
//   }

//   User? _user;
//   User? get user => _user;
//   set user(User? value) {
//     _user = value;
//     notify();
//   }

//   String _phoneNumber = '';
//   String get phoneNumber => _phoneNumber;
//   set phoneNumber(String value) {
//     _phoneNumber = value;
//     notify();
//   }

//   String _city = '';
//   String get city => _city;
//   void setCity(String value) {
//     _city = value;
//     notify();
//   }

//   String getUserName() {
//     return _user?.fullName ?? '';
//   }

//   String getEmail() {
//     return _user?.userName ?? '';
//   }

//   int getCoins() {
//     return _user?.coins ?? 0;
//   }

//   Future<void> updateUserInfo() async {
//     try {
//       final response = await dioClient.post(
//         'https://testapi.premed.pk/UpdateAccountInfo',
//         data: {
//           'fullname': _user?.fullName,
//           'phonenumber': _phoneNumber,
//           'city': _city,
//           'school': _user?.school,
//         },
//       );

//       // Assuming the API returns {"Error": false} on success
//       if (response.data['Error'] == false) {
//         // Optionally, update local user information if needed
//         // For example, if the API updates other fields like 'school'
//         // _user = User.fromJson(response.data['data']);

//         notify(); // Notify listeners that the data has changed
//       } else {
//         // Handle error if necessary
//         print('Failed to update user information');
//       }
//     } catch (error) {
//       // Handle Dio errors or other exceptions
//       print('Error updating user information: $error');
//     }
//   }
// }
