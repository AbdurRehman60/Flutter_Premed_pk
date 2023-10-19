import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:premedpk_mobile_app/utils/secure_storage.dart';
import 'package:premedpk_mobile_app/utils/shared_prefrences.dart';
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
      "Password": password,
    };

    _loggedInStatus = Status.Authenticating;
    notify();

    try {
      Response response = await _client.post(
        Endpoints.login,
        data: loginData,
      );
      print('😢 = `$response');
      //checking if api call was successfull
      if (response.statusCode == 200) {
        //mapping api call body  to responsedata
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        //checking if body caught any errors from server
        // if  there is no error the if code block executes
        // if (responseData['header']['error'] == 0) {
        //   //creating a user obejct from responsedata
        //   User authUser = User.fromJson(responseData['body']);

        //   // saving that user in shared preferences
        //   UserPreferences().saveUser(authUser);

        //   //saving refreshToken in secure storage
        //   SecureStorage()
        //       .saveRefreshToken(responseData['body']['refreshToken']);

        //   //notifiying Ui about loggedin Status
        //   _loggedInStatus = Status.LoggedIn;
        //   notify();

        //   //returning result to app
        //   result = {
        //     'status': true,
        //     'message': 'Successful',
        //     'user': authUser,
        //   };
        // } else {
        //   // error exists in the header file
        //   //changing loggedin status

        //   _loggedInStatus = Status.NotLoggedIn;
        //   notify();

        //   //returning result with error message back

        //   result = {
        //     'status': false,
        //     'message': responseData['header']['errorMessage'],
        //   };
        // }
      } else {
        //executes if API call was not sucessfull
        //changing loggedin status

        _loggedInStatus = Status.NotLoggedIn;
        notify();

        //returning  results
        result = {
          'status': false,
          'message': json.decode(response.data)['error']
        };
      }
    } on DioError catch (e) {
      //catching dio executiuon error
      //changing logged in status

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

  Future<Map<String, dynamic>> logout() async {
    var result;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String accessToken = prefs.getString("accessToken") ?? '';

    _loggedInStatus = Status.Authenticating;
    notify();
    try {
      Response response = await _client.post(
        Endpoints.logout,
        options: Options(
          headers: {"Authorization": "Bearer $accessToken"},
        ),
      );

      //checking if api call was successfull
      if (response.statusCode == 200) {
        //mapping api call body  to responsedata
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        //checking if body caught any errors from server
        // if  there is no error the if code block executes
        if (responseData['header']['error'] == 0) {
          //creating a user obejct from responsedata

          // removing that user from shared preferences

          SecureStorage().removeRefreshToken();

          //notifiying Ui about loggedout Status
          _loggedInStatus = Status.LoggedOut;
          notify();

          //returning result to app
          result = {
            'status': true,
            'message': 'Successful',
          };
        } else {
          // error exists in the header file
          //changing loggedin status

          _loggedInStatus = Status.LoggedIn;
          notify();

          //returning result with error message back

          result = {
            'status': false,
            'message': responseData['header']['errorMessage'],
          };
        }
      } else {
        //executes if API call was not sucessfull
        //changing loggedin status

        _loggedInStatus = Status.LoggedIn;
        notify();

        //returning  results
        result = {
          'status': false,
          'message': json.decode(response.data)['error']
        };
      }
    } on DioError catch (e) {
      //catching dio executiuon error
      //changing logged in status

      _loggedInStatus = Status.LoggedIn;
      notify();
      // print('error + $e.message');
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }
}
