import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  Future<void> fetchAndSaveFcmToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fcmToken = prefs.getString('fcmToken');

    if (fcmToken == null || fcmToken.isEmpty) {
      fcmToken = await FirebaseMessaging.instance.getToken();
      print("New FCM token generated: $fcmToken");

      if (fcmToken != null) {
        await prefs.setString('fcmToken', fcmToken);
      } else {
        print("Error: Could not retrieve FCM token");
      }
    } else {
      print("FCM token retrieved from SharedPreferences: $fcmToken");
    }
  }


  //
  // Future<Map<String, dynamic>> login(String email, String password, bool isApp) async {
  //   await fetchAndSaveFcmToken(); // Ensure FCM token is available before proceeding
  //
  //   Map<String, Object?> result;
  //   final Map<String, dynamic> loginData = {
  //     "username": email,
  //     "password": password,
  //     "isApp": isApp
  //   };
  //   _loggedInStatus = Status.Authenticating;
  //   notifyListeners();
  //
  //   try {
  //     final Response response = await _client.post(
  //       Endpoints.login,
  //       data: loginData,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData =
  //       Map<String, dynamic>.from(response.data);
  //
  //       if (responseData["success"]) {
  //         final Map<String, dynamic> userResponse = await getLoggedInUser();
  //         final String? fcmToken = await UserPreferences().getFcmToken();
  //         print("this is the FCM token while login $fcmToken");
  //         await _client.post(
  //           Endpoints.SaveFCMToken,
  //           data: {'fcmToken': fcmToken},
  //         );
  //
  //         if (userResponse['status']) {
  //           _loggedInStatus = Status.LoggedIn;
  //           notifyListeners();
  //           result = {
  //             'status': userResponse["status"],
  //             'message': userResponse["message"],
  //           };
  //         } else {
  //           _loggedInStatus = Status.NotLoggedIn;
  //           notifyListeners();
  //           result = {
  //             'status': userResponse["status"],
  //             'message': userResponse["message"],
  //           };
  //         }
  //       } else {
  //         _loggedInStatus = Status.NotLoggedIn;
  //         notifyListeners();
  //         result = {
  //           'status': responseData["success"],
  //           'message': responseData["status"],
  //         };
  //       }
  //     } else {
  //       _loggedInStatus = Status.NotLoggedIn;
  //       notifyListeners();
  //       result = {
  //         'status': false,
  //         'message': json.decode(response.data),
  //       };
  //     }
  //   } on DioException catch (e) {
  //     _loggedInStatus = Status.NotLoggedIn;
  //     notifyListeners();
  //     result = {
  //       'status': false,
  //       'message': e.message,
  //     };
  //   }
  //
  //   return result;
  // }

  Future<Map<String, dynamic>> login(String email, String password, bool isApp) async {
    Map<String, Object?> result;
    final Map<String, dynamic> loginData = {
      "username": email,
      "password": password,
      "isApp": isApp
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

          //TO-DO SAVE USER LOGIN DETAILS (MOBILE DEVICE ETC.)

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


        //returning  results
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

    notifyListeners();

    return result;
  }

  Future<Map<String, dynamic>> getLoggedInUser() async {
    Map<String, dynamic> result;

    try {
      final response = await _client.get(Endpoints.getLoggedInUser);
      final responseData = response is Map<String, dynamic>
          ? response
          : response.data as Map<String, dynamic>;
      final lastOnboardingPageFromResponse = responseData["lastOnboardingPage"];
      if (responseData["isloggedin"] == true) {
        final User user = User.fromJson(responseData);
        await UserPreferences().saveUser(user);
        UserProvider().user = user;

        final String? accountType = user.accountType;
        final String lastOnboardingPage = user.info.lastOnboardingPage;

        if (accountType == "google" && user.info.lastOnboardingPage.isEmpty) {
          result = {
            'status': true,
            'message': "OnboardingOne",
          };
        } else {
          if (lastOnboardingPage == "/auth/onboarding") {
            result = {
              'status': true,
              'message': "OnboardingOne",
            };
          } else if (lastOnboardingPage == "/auth/onboarding/entrance-exam") {
            result = {
              'status': true,
              'message': "EntryTest",
            };
          } else if (lastOnboardingPage == "/auth/onboarding/entrance-exam/pre-medical" ||
              lastOnboardingPage == "/auth/onboarding/entrance-exam/pre-engineering") {
            result = {
              'status': true,
              'message': "RequiredOnboarding",
            };
          } else if (lastOnboardingPage == "/auth/onboarding/entrance-exam/pre-medical/features" ||
              lastOnboardingPage == "/auth/onboarding/entrance-exam/pre-engineering/features") {
            result = {
              'status': true,
              'message': "OptionalOnboarding",
            };
          } else if (lastOnboardingPage == "/auth/onboarding/entrance-exam/pre-medical/features/additional-info") {
            result = {
              'status': true,
              'message': "home",
            };
          } else {
            result = {
              'status': true,
              'message': "unknown",
            };
          }
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

  Future<Map<String, dynamic>> signup(
      String email, String password, String fullName, bool appUser) async {
    Map<String, Object?> result;
    final Map<String, dynamic> signupData = {
      "fullname": fullName,
      "username": email,
      "password": password,
      "appUser": appUser,
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
        if (responseData["success"] == true) {
          final Map<String, dynamic> userResponse = await getLoggedInUser();

          result = {
            'status': userResponse['status'],
            'message': userResponse['status']
                ? "Signup successful"
                : userResponse['message'],
          };
        } else {
          result = {
            'status': false,
            'message': responseData["status"] ?? responseData["Text"],
          };
        }
      } else {
        result = {
          'status': false,
          'message': json.decode(response.data),
        };
      }
    } on DioException catch (e) {
      _signUpStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': e.message,
      };
    } finally {
      _signUpStatus = Status.NotLoggedIn;
      notifyListeners();
    }

    return result;
  }

  Future<Map<String, dynamic>> requiredOnboarding({
    required String username,
    required String lastOnboardingPage,
    required List<String> selectedExams,
    required List<String> selectedFeatures,
    required String city,
    required String educationSystem,
    required String year,
    required String parentContactNumber,
    required String approach,
    required String phoneNumber,
    required String institution,
  }) async {
    Map<String, Object?> result;

    final Map<String, dynamic> payload = {
      "username": username,
      "info": {
        "lastOnboardingPage": lastOnboardingPage,
        if (selectedExams.isNotEmpty) "exam": selectedExams,
        if (selectedFeatures.isNotEmpty) "features": selectedFeatures,
        "year": year,
        "educationSystem": educationSystem,
        "institution": institution,
        "approach": approach,
      },
      "city": city,
      "educationSystem": educationSystem,
      "year": year,
      "parentContactNumber": parentContactNumber,
      "onboarding": true,
      "phonenumber": phoneNumber,
      "institution": institution,
      "approach": approach,
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
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fcmToken = prefs.getString('fcmToken');

      if (fcmToken == null || fcmToken.isEmpty) {
        print("FCM token is null during logout. Attempting to regenerate...");
        await fetchAndSaveFcmToken();
        fcmToken = prefs.getString('fcmToken');
      }

      if (fcmToken != null && fcmToken.isNotEmpty) {
        print("FCM token before deletion: $fcmToken");
        await _client.post(
          Endpoints.DeleteFCMToken,
          data: {'fcmToken': fcmToken},
        );

        final Response response = await _client.logout(Endpoints.logout);
        if (response.statusCode == 200) {
          await UserPreferences().logOut();
          return {'status': true, 'message': 'Logged out successfully'};
        } else {
          print('Server error during logout: ${response.statusCode}');
          return {'status': false, 'message': 'Logout failed with status code ${response.statusCode}'};
        }
      } else {
        print("Error: Unable to retrieve FCM token during logout");
        return {'status': false, 'message': 'FCM token missing during logout'};
      }
    } catch (e) {
      print("Exception during logout: $e");
      return {'status': false, 'message': 'An error occurred during logout'};
    }
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
        "token": googleAuth.accessToken.toString(),
        "isApp": true,
      };

      try {
        final Response response = await _client.post(
          Endpoints.continueWithGoogle,
          data: payload,
        );

        if (response.statusCode == 200) {
          print('response statusCode : ${response.statusCode}');
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
    } on DioException catch (e) {
      result = {
        'status': false,
        'message': e.response?.data ?? e.message,
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> checkOnboarding() async {
    Map<String, dynamic> result;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('lastOnboardingPage')) {
        final lastOnboardingPage = prefs.getString('lastOnboardingPage');

        if (lastOnboardingPage == "/auth/onboarding") {
          result = {
            'status': true,
            'message': "OnboardingOne",
          };
        } else if (lastOnboardingPage == "/auth/onboarding/entrance-exam") {
          result = {
            'status': true,
            'message': "EntryTest",
          };
        } else if (lastOnboardingPage ==
            "/auth/onboarding/entrance-exam/pre-medical" ||
            lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-engineering") {
          result = {
            'status': true,
            'message': "RequiredOnboarding",
          };
        } else if (lastOnboardingPage ==
            "/auth/onboarding/entrance-exam/pre-medical/features" ||
            lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-engineering/features") {
          result = {
            'status': true,
            'message': "OptionalOnboarding",
          };
        } else if (lastOnboardingPage ==
            "/auth/onboarding/entrance-exam/pre-medical/features/additional-info") {
          result = {
            'status': true,
            'message': "home",
          };
        } else {
          result = {
            'status': true,
            'message': "unknown",
          };
        }
      } else {
        result = {
          'status': true,
          'message': "home",
        };
      }
    } catch (e) {
      result = {
        'status': false,
        'message': "Error in fetching Onboarding Details: ${e.toString()}",
      };
    }

    return result;
  }

}
