import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
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
    _signUpStatus = value;
  }
  User? _user;
  Info? _info;

  User? get user => _user;
  set user(User? value) {
    _user = value;
    _info = value?.info;
    notifyListeners();
  }

  String get lastOnboardingPage {
    print("Getting lastOnboardingPage: ${_info?.lastOnboardingPage}");
    return _info?.lastOnboardingPage ?? '';
  }

  String _parentContactNumber = '';
  String get parentContactNumber => _parentContactNumber;
  set parentContactNumber(String value) {
    _parentContactNumber = value;
    notifyListeners();
  }

  String _academyJoined = 'No';
  String get academyJoined => _academyJoined;
  set academyJoined(String value) {
    _academyJoined = value;
    notifyListeners();
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

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  String _whatsappNumber = '';
  String get whatsappNumber => _whatsappNumber;
  set whatsappNumber(String value) {
    _whatsappNumber = value;
    notifyListeners();
  }

  String _intendedYear = 'FSc 1st Year/AS Level';
  String get intendedYear => _intendedYear;
  set intendedYear(String value) {
    _intendedYear = value;
    notifyListeners();
  }

  String _city = '';
  String get city => _city;
  void setCity(String value) {
    _city = value;
    notifyListeners();
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
    notifyListeners();
  }

  String _exam = '';
  String get exam => _exam;
  set exam(String value) {
    _exam = value;
    notifyListeners();
  }

  List<String> _features = [];
  List<String> get features => _features;
  set features(List<String> value) {
    _features = value;
    notifyListeners();
  }

  String _year = '';
  String get year => _year;
  set year(String value) {
    _year = value;
    notifyListeners();
  }

  String _approach = '';
  String get approach => _approach;
  set approach(String value) {
    _approach = value;
    notifyListeners();
  }

  String _educationSystem = '';
  String get educationSystem => _educationSystem;
  set educationSystem(String value) {
    _educationSystem = value;
    notifyListeners();
  }

  String _institution = '';
  String get institution => _institution;
  set institution(String value) {
    _institution = value;
    notifyListeners();
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleUser;
  GoogleSignInAccount get googleUser => _googleUser!;

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, Object?> result;
    final Map<String, dynamic> loginData = {
      "username": email,
      "password": password,
    };
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

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

          if (userResponse['status']) {
            _loggedInStatus = Status.LoggedIn;
            notifyListeners();
            result = {
              'status': userResponse["status"],
              'message': userResponse["message"],
            };
          } else {
            _loggedInStatus = Status.NotLoggedIn;
            notifyListeners();
            result = {
              'status': userResponse["status"],
              'message': userResponse["message"],
            };
          }
        } else {
          _loggedInStatus = Status.NotLoggedIn;
          notifyListeners();
          result = {
            'status': responseData["success"],
            'message': responseData["status"],
          };
        }
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {
          'status': false,
          'message': json.decode(response.data),
        };
      }
    } on DioException catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': e.message,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> getLoggedInUser() async {
    Map<String, Object?> result;

    try {
      final response = await _client.get(Endpoints.getLoggedInUser);
      final responseData = response is Map<String, dynamic> ? response : response.data;

      if (responseData["isloggedin"] == true) {
        final User user = User.fromJson(responseData);
        await UserPreferences().saveUser(user);

        UserProvider().user = user;
        if (responseData.containsKey("onboarding") && responseData["onboarding"] == true) {
          result = {
            'status': true,
            'message': "home",
          };
        } else {
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
      notifyListeners();
      result = {
        'status': false,
        'message': e.message,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> signup(String email, String password, String fullName) async {
    Map<String, Object?> result;
    final Map<String, dynamic> signupData = {
      "fullname": fullName,
      "username": email,
      "password": password,
    };
    _signUpStatus = Status.Authenticating;
    notifyListeners();

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
        notifyListeners();

        result = {
          'status': false,
          'message': json.decode(response.data),
        };
      }
    } on DioException catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
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
    notifyListeners();

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

  Future<Map<String, dynamic>> requiredOnboarding({
    required String username,
    required String lastOnboardingPage,
  }) async {
    Map<String, Object?> result;

    final Map<String, dynamic> payload = {
      "city": city,
      "info": {
        "lastOnboardingPage": lastOnboardingPage,
        if (exam.isNotEmpty) "exam": exam,
        if (features.isNotEmpty) "features": features,
        if (year.isNotEmpty) "year": year,
        if (approach.isNotEmpty) "approach": approach,
        if (educationSystem.isNotEmpty) "educationSystem": educationSystem,
        if (institution.isNotEmpty) "institution": institution,
      },
      "onboarding": true,
      "optionalOnboarding": false,
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    try {
      final Response response = await _client.post(
        Endpoints.RequiredOnboarding,
        data: payload,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
        Map<String, dynamic>.from(response.data);

        if (responseData.containsKey('info') && responseData['info'] != null) {
          _info = Info.fromJson(responseData['info']);
          notifyListeners();
        }

        await getLoggedInUser();
        _loggedInStatus = Status.LoggedIn;
        _signUpStatus = Status.LoggedIn;
        notifyListeners();
        result = {
          'status': responseData["success"],
          'message': responseData["status"],
        };
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        _signUpStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {
          'status': false,
          'message': json.decode(response.data),
        };
      }
    } on DioException catch (e) {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
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
    notifyListeners();

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
        _phoneNumber = '';
        _whatsappNumber = '';
        _intendedYear = 'FSc 1st Year/AS Level';
        _city = '';
        _country = '';
        _school = '';
        _parentContactNumber = '';
        _academyJoined = 'No';
        _parentFullName = '';
        _intendFor = [];

        notifyListeners();

        result = {
          'status': true,
          'message': 'Successful',
        };
      } else {
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();
        result = {
          'status': false,
          'message': response.data.toString(),
        };
      }
    } on DioError catch (e) {
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();
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
