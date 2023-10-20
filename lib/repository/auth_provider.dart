import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:premedpk_mobile_app/api_manager/dio client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio client/endpoints.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:premedpk_mobile_app/repository/user_provider.dart';
import 'package:premedpk_mobile_app/utils/secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { NotLoggedIn, LoggedIn, Authenticating, LoggedOut }

class AuthProvider extends ChangeNotifier {
  final List<CameraDescription> cameras;
  final DioClient _client = DioClient();
  BuildContext _context;
  bool _Loggedin = false;

  AuthProvider(this.cameras, this._context);

  Status _loggedInStatus = Status.NotLoggedIn;
  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  bool get Loggedin => _Loggedin;

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
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        // Handle the user data here and set it in your UserProvider.
        User user = User.fromJson(responseData);
        Provider.of<UserProvider>(_context, listen: false).setUser(user);

        // Set the Loggedin flag to true
        _Loggedin = true;

        result = {
          'status': true,
          'message': 'Successful',
        };
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notify();
        result = {'status': false, 'message': response.data.toString()};
      }
    } on DioException catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notify();
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
