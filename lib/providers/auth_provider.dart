import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:premedpk_mobile_app/utils/secure_storage.dart';
import 'package:premedpk_mobile_app/utils/dialCode_to_country.dart';
import 'package:premedpk_mobile_app/utils/services/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  NotLoggedIn,
  LoggedIn,
  Authenticating,
  LoggedOut,
  Init,
  Fetching,
}

class AuthProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _SignUpStatus = Status.Authenticating;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get SignUpStatus => _SignUpStatus;

  set SignUpStatus(Status value) {
    _loggedInStatus = value;
  }

  String _parentContactNumber = '';
  String get parentContactNumber => _parentContactNumber;
  set parentContactNumber(String value) {
    _parentContactNumber = value;
    notify();
  }

  String _academyJoined = 'No';
  String get academyJoined => _academyJoined;
  set academyJoined(String value) {
    _academyJoined = value;

    notify();
  }

  String _parentFullName = '';
  String get parentFullName => _parentFullName;
  set parentFullName(String value) {
    _parentFullName = value;
  }

  List<String> _intendFor = [];

  List<String> get intendFor => _intendFor;

  set intendFor(List<String> value) {
    _intendFor = value;
    notifyListeners();
  }

//required on boarding data from here
  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notify();
  }

  String _whatsappNumber = '';
  String get whatsappNumber => _whatsappNumber;
  set whatsappNumber(String value) {
    _whatsappNumber = value;
    notify();
  }

  String _intendedYear = 'FSc 1st Year/AS Level';
  String get intendedYear => _intendedYear;
  set intendedYear(String value) {
    _intendedYear = value;
    notify();
  }

  String _City = '';
  String get City => _City;
  void setCity(String value) {
    _City = value;
    notify();
  }

  String _country = '';
  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String _School = '';
  String get School => _School;
  void setSchool(String value) {
    _School = value;
    notify();
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
          final Map<String, dynamic> userResponse = await getLoggedInUser();

          if (userResponse['status']) {
            result = {
              'status': userResponse["status"],
              'message': userResponse["message"],
            };
          } else {
            result = {
              'status': userResponse["status"],
              'message': userResponse["message"],
            };
          }

          _loggedInStatus = Status.LoggedIn;
          notify();
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
        result = {
          'status': false,
          'message': json.decode(response.data),
        };
      }
    } on DioException catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notify();

      result = {
        'status': false,
        'message': e.message,
      };
    }
    print(
      'login api result: ${result}',
    );
    return result;
  }

  Future<Map<String, dynamic>> getLoggedInUser() async {
    var result;

    try {
      final response = await _client.get(
        Endpoints.getLoggedInUser,
      );

      if (response["isloggedin"]) {
        User user = User.fromJson(response);
        await UserPreferences().saveUser(user);
        if (response["onboarding"]) {
          result = {
            'status': true,
            'message': "home",
          };
        } else {
          // await UserPreferences().saveNewUser(response["onboarding"]);
          result = {
            'status': true,
            'message': "onboarding",
          };
        }
      } else {
        result = {
          'status': false,
          'message': "Error in fetching User Details",
        };
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
        if (responseData["success"]) {
          final Map<String, dynamic> userResponse = await getLoggedInUser();

          if (userResponse['status']) {
            result = {
              'status': userResponse["status"],
              'message': userResponse["status"],
            };
          } else {
            result = {
              'status': userResponse["status"],
              'message': userResponse["message"],
            };
          }
        } else {
          result = {
            'status': false,
            'message': responseData["status"] ?? responseData["Text"],
          };
        }
      } else {
        _SignUpStatus = Status.Authenticating;
        notify();

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

  Future<Map<String, dynamic>> optionalOnboarding() async {
    var result;

    final Map<String, dynamic> payload = {
      "academyJoined": academyJoined,
      "parentContactNumber": parentContactNumber,
      "parentFullName": parentFullName,
      "optionalOnboarding": true,
      "intendFor": intendFor,
    };

    _loggedInStatus = Status.Authenticating;
    notify();

    try {
      Response response = await _client.post(
        Endpoints.OptionalOnboarding,
        data: payload,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        await getLoggedInUser();

        result = {
          'status': responseData["success"],
          'message': responseData["status"],
        };
      } else {
        result = {
          'status': false,
          'message': json.decode(response.data),
        };
      }
    } on DioException catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> requiredOnboarding() async {
    var result;

    final Map<String, dynamic> payload = {
      "phonenumber": phoneNumber,
      "city": City,
      "school": School,
      "country": getCountryName(country.replaceFirst('+', '')),
      "whichYear": intendedYear,
      "whatsappNumber": whatsappNumber.isNotEmpty ? whatsappNumber : phoneNumber
    };

    _loggedInStatus = Status.Authenticating;
    notify();

    try {
      Response response = await _client.post(
        Endpoints.RequiredOnboarding,
        data: payload,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            Map<String, dynamic>.from(response.data);

        await getLoggedInUser();

        result = {
          'status': responseData["success"],
          'message': responseData["status"],
        };
      } else {
        result = {
          'status': false,
          'message': json.decode(response.data),
        };
      }
    } on DioException catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }

    return result;
  }

//   Future<Map<String, dynamic>> logout() async {
//     var result;

//     if (!_Loggedin) {
//       // Do not proceed with logout if not logged in
//       return {'status': false, 'message': 'Not logged in'};
//     }

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String accessToken = prefs.getString("accessToken") ?? '';

//     _loggedInStatus = Status.Authenticating;
//     notify();

//     try {
//       Response response = await _client.post(
//         Endpoints.logout,
//         options: Options(
//           headers: {"Authorization": "Bearer $accessToken"},
//         ),
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData =
//             Map<String, dynamic>.from(response.data);

//         SecureStorage().removeRefreshToken();

//         _loggedInStatus = Status.LoggedOut;
//         _Loggedin = false; // Set Loggedin to false after logout
//         notify();

//         result = {
//           'status': true,
//           'message': 'Successful',
//         };
//       } else {
//         _loggedInStatus = Status.LoggedIn;
//         notify();
//         result = {
//           'status': false,
//           'message': response.data.toString(),
//         };
//       }
//     } on DioError catch (e) {
//       _loggedInStatus = Status.LoggedIn;
//       notify();
//       result = {
//         'status': false,
//         'message': e.message,
//       };
//     }
//     return result;
//   }
}
