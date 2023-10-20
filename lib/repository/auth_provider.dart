import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:premedpk_mobile_app/utils/secure_storage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import 'package:premedpk_mobile_app/export.dart';

// ignore: constant_identifier_names
enum Status { NotLoggedIn, LoggedIn, Authenticating, LoggedOut }

class AuthProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _loggedInStatus = Status.NotLoggedIn;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;
    final Map<String, dynamic> loginData = {
      "username": email,
      "password": password,
    };
    _loggedInStatus = Status.Authenticating;
    notify();
    try {
      Response response = await _client.post(
        Endpoints.login,
        data: loginData,
      );
      if (response.statusCode == 200) {
        final cookies = response.headers.map['set-cookie'];
        print("Cookie,$cookies");

        // final Map<String, dynamic> responseData =
        //     Map<String, dynamic>.from(response.data);
        print('login suvvess');
        result = {
          'status': true,
          'message': 'Successful',
        };
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notify();

        //returning  results
        result = {'status': false, 'message': json.decode(response.data)};
      }
    } on DioException catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notify();
      // print('error + $e.message');
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> getLoggedInUser() async {
    var result;

    try {
      final response = await _client.get(
        Endpoints.getLoggedInUser,
      );
      print(response);
      result = {
        'status': true,
        'message': 'Successful',
      };
      // if (response.statusCode == 200) {
      //   print(response);

      //   result = {
      //     'status': true,
      //     'message': 'Successful',
      //   };
      // } else {
      //   //returning  results
      //   result = {
      //     'status': false,
      //     'message': json.decode(response.data),
      //   };
      // }
    } on DioException catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notify();
      // print('error + $e.message');
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }
  // Future<Map<String, dynamic>> logout() async {
  //   var result;

  //   if (!_Loggedin) {
  //     // Do not proceed with logout if not logged in
  //     return {'status': false, 'message': 'Not logged in'};
  //   }

  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String accessToken = prefs.getString("accessToken") ?? '';

  //   _loggedInStatus = Status.Authenticating;
  //   notify();

  //   try {
  //     Response response = await _client.post(
  //       Endpoints.logout,
  //       options: Options(
  //         headers: {"Authorization": "Bearer $accessToken"},
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData =
  //           Map<String, dynamic>.from(response.data);

  //       SecureStorage().removeRefreshToken();

  //       _loggedInStatus = Status.LoggedOut;
  //       _Loggedin = false; // Set Loggedin to false after logout
  //       notify();

  //       result = {
  //         'status': true,
  //         'message': 'Successful',
  //       };
  //     } else {
  //       _loggedInStatus = Status.LoggedIn;
  //       notify();
  //       result = {
  //         'status': false,
  //         'message': response.data.toString(),
  //       };
  //     }
  //   } on DioError catch (e) {
  //     _loggedInStatus = Status.LoggedIn;
  //     notify();
  //     result = {
  //       'status': false,
  //       'message': e.message,
  //     };
  //   }
  //   return result;
  // }
}
