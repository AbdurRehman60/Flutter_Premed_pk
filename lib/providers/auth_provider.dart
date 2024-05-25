
// ignore_for_file: constant_identifier_names, unnecessary_getters_setters, deprecated_member_use

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
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
  Status _signUpStatus = Status.NotLoggedIn;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get signUpStatus => _signUpStatus;

  set signUpStatus(Status value) {
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

  String _city = '';
  String get city => _city;
  void setCity(String value) {
    _city = value;
    notify();
  }

  String _country = '';
  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String _school = '';
  String get school => _school;
  void setSchool(String value) {
    _school = value;
    notify();
  }

  //GoogleSignin

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleUser;
  GoogleSignInAccount get googleUser => _googleUser!;

  void notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, Object?> result;
    final Map<String, dynamic> loginData = {
      "username": email,
      "password": password,
    };
    _loggedInStatus = Status.Authenticating;
    notify();

    try {
      final Response response = await _client.post(
        Endpoints.login,
        data: loginData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);

        if (responseData["success"]) {
          final Map<String, dynamic> userResponse = await getLoggedInUser();

          final SharedPreferences prefs = await SharedPreferences.getInstance();

          final String? fcmToken = prefs.getString('fcmToken');

          await _client.post(
            Endpoints.SaveFCMToken,
            data: {'fcmToken': fcmToken},
          );

          //TO-DO SAVE USER LOGIN DETAILS (MOBILE DEVICE ETC.)

          if (userResponse['status']) {
            _loggedInStatus = Status.LoggedIn;
            notify();
            result = {
              'status': userResponse["status"],
              'message': userResponse["message"],
            };
          } else {
            _loggedInStatus = Status.NotLoggedIn;
            notify();
            result = {
              'status': userResponse["status"],
              'message': userResponse["message"],
            };
          }
        } else {
          _loggedInStatus = Status.NotLoggedIn;
          notify();
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

    notify();
    return result;
  }

  Future<Map<String, dynamic>> getLoggedInUser() async {
    Map<String, Object?> result;

    try {
      final response = await _client.get(
        Endpoints.getLoggedInUser,
      );

      if (response["isloggedin"]) {
        final User user = User.fromJson(response);
        await UserPreferences().saveUser(user);

        UserProvider().user = user;
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
    Map<String, Object?> result;
    final Map<String, dynamic> signupData = {
      "fullname": fullName,
      "username": email,
      "password": password,
    };
    if (referralCode != null && referralCode.isNotEmpty) {
      signupData["referralCode"] = referralCode;
    }
    _signUpStatus = Status.Authenticating;
    notify();

    try {
      final Response response = await _client.post(
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
        _signUpStatus = Status.Authenticating;
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
    Map<String, Object?> result;

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
      final Response response = await _client.post(
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
    Map<String, Object?> result;

    final Map<String, dynamic> payload = {
      "phonenumber": phoneNumber,
      "city": city,
      "school": school,
      "country": getCountryName(country.replaceFirst('+', '')),
      "whichYear": intendedYear,
      "whatsappNumber": whatsappNumber.isNotEmpty ? whatsappNumber : phoneNumber
    };

    _loggedInStatus = Status.Authenticating;
    notify();

    try {
      final Response response = await _client.post(
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

  Future<Map<String, dynamic>> logout() async {
    Map<String, Object?> result;

    _loggedInStatus = Status.Authenticating;
    notify();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? fcmToken = prefs.getString('fcmToken');
      await _client.post(
        Endpoints.DeleteFCMToken,
        data: {'fcmToken': fcmToken},
      );

      final Response response = await _client.logout(
        Endpoints.logout,
      );

      if (response.statusCode == 200) {
        await UserPreferences().logOut();
        _loggedInStatus = Status.LoggedOut;
        notify();

        result = {
          'status': true,
          'message': 'Successful',
        };
      } else {
        _loggedInStatus = Status.LoggedIn;
        notify();
        result = {
          'status': false,
          'message': response.data.toString(),
        };
      }
    } on DioError catch (e) {
      _loggedInStatus = Status.LoggedIn;
      notify();
      result = {
        'status': false,
        'message': e.message,
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> continueWithGoogle() async {
    Map<String, Object?> result;

    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        result = {
          'status': false,
          'message': 'No Account Selected',
        };

        return result;
      }
      _googleUser = user;

      final googleAuth = await googleUser.authentication;

      final Map<String, dynamic> payload = {
        "username": googleUser.email,
        "fullname": googleUser.displayName.toString(),
        "picture": googleUser.photoUrl.toString(),
        "token": googleAuth.accessToken.toString()
      };

      try {
        final Response response = await _client.post(
          Endpoints.continueWithGoogle,
          data: payload,
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);

          if (responseData["success"]) {
            final Map<String, dynamic> userResponse = await getLoggedInUser();

            final SharedPreferences prefs =
            await SharedPreferences.getInstance();

            final String? fcmToken = prefs.getString('fcmToken');

            await _client.post(
              Endpoints.SaveFCMToken,
              data: {'fcmToken': fcmToken},
            );

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
          } else {
            result = {
              'status': responseData["success"],
              'message': responseData["status"],
            };
          }
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

      _googleUser = null;
      await googleSignIn.disconnect();
    } catch (e) {
      result = {
        'status': false,
        'message': e.toString(),
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    Map<String, Object?> result;
    final Map<String, dynamic> forgotPasswordData = {
      "username": email,
    };

    try {
      final Response response = await _client.post(
        Endpoints.forgotPassword,
        data: forgotPasswordData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);

        if (responseData["success"] != null) {
          result = {
            'status': responseData["success"],
            'message': responseData["status"],
          };
        } else {
          result = {
            'status': false,
            'message': response.data["ErrorText"],
          };
        }
      } else {
        result = {
          'status': false,
          'message': 'Error',
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': e.response?.data ?? e.message,
      };
    }

    return result;
  }
}
