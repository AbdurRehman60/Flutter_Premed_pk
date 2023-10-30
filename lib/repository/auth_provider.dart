import 'dart:convert';

import 'package:dio/dio.dart';

import '../api_manager/dio client/dio_client.dart';
import '../api_manager/dio client/endpoints.dart';
import 'package:premedpk_mobile_app/export.dart';

// ignore: constant_identifier_names
enum Status {
  NotLoggedIn,
  LoggedIn,
  Authenticating,
  LoggedOut,
}

class AuthProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _SignUpStatus = Status.Authenticating;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  String _parentContactNumber = '';
  String get parentContactNumber => _parentContactNumber;
  set parentContactNumber(String value) {
    _parentContactNumber = value;
    notify();
  }

  String _academyJoined = 'Yes';
  String get academyJoined => _academyJoined;
  set academyJoined(String value) {
    _academyJoined = value;
    notify();
  }

  String _parentFullName = '';
  String get parentFullName => _parentFullName;
  set parentFullName(String value) {
    _parentFullName = value;
    notifyListeners();
  }

  List<String> _intendFor = [];

  List<String> get intendFor => _intendFor;

  set intendFor(List<String> value) {
    _intendFor = value;
    notifyListeners();
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
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        if (responseData["success"]) {
          result = {
            'status': responseData["success"],
            'message': responseData["status"],
          };
        } else {
          result = {
            'status': responseData["success"],
            'message': responseData["status"],
          };
        }
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

  Future<Map<String, dynamic>> signup(
    String email,
    String password,
    String fullName,
    String? referralCode,
  ) async {
    var result;
    final Map<String, dynamic> signupData = {
      "fullname": fullName,
      "username": email,
      "password": password,
    };
    if (referralCode != null && referralCode.isNotEmpty) {
      signupData["referralCode"] = referralCode;
    }
    _SignUpStatus = Status.Authenticating;
    notify();

    try {
      Response response = await _client.post(
        Endpoints.signup,
        data: signupData,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);
        if (responseData["responseData"] == "success") {
          result = {
            'status': responseData["success"],
            'message': responseData["status"],
          };
        } else {
          result = {
            'status': responseData["success"],
            'message': responseData["status"],
          };
        }
      } else {
        _SignUpStatus = Status.Authenticating;
        notify();
        //returning  results
        result = {
          'status': false,
          'message': json.decode(response.data),
        };
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

  Future<Map<String, dynamic>> postOptionalOnboarding(
      Map<String, dynamic> optionalOnboardingData) async {
    var result;

    // try {
    //   Response response = await _client.post(
    //     Endpoints.OptionalOnboarding,
    //     data: request,
    //   );

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> responseData =
    //         Map<String, dynamic>.from(response.data);

    //     result = {
    //       'status': responseData["success"],
    //       'message': responseData["status"],
    //     };
    //     print(responseData);
    //   } else {
    //     result = {
    //       'status': false,
    //       'message': json.decode(response.data),
    //     };
    //   }
    // } on DioException catch (e) {
    //   result = {
    //     'status': false,
    //     'message': e.message,
    //   };
    // }
    print(optionalOnboardingData);
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
