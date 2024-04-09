// ignore_for_file: constant_identifier_names

class Endpoints {
  Endpoints._();
  //Ports
  static const String serverPort = "4002";

  // base url

  static const String baseUrl = "http://192.168.10.6"; //saad

  //specific URLs
  // static const String serverURL = "${baseUrl}:${serverPort}";
  static const String serverURL = "https://prodapi.premed.pk";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 15000);
  //auth endpoints
  static const String login = '/login';
  static const String logout = '/logout';
  static const String signup = '/api/auth/signup';
  static const String getLoggedInUser = '/LoggedInUser';
  static const String continueWithGoogle = '/api/auth/google-login';
  static const String forgotPassword = '/Forgot-Password';

  //onboarding endpoints
  static const String OptionalOnboarding = '/api/auth/optional-onboarding';
  static const String RequiredOnboarding = '/api/auth/required-onboarding';
  //notes endpoints
  static const String Guides = '/api/notes/allguides';
  static const String RevisionNotes = '/api/notes/all';
  //expertsolution endpoints
  static const String DoubtUpload = '/DoubtUpload';
  static const String UserSolved = '/GetDoubtsByUser';
  static const String RateDoubt = '/RateUser';

  // static const String UserSolved = '/UserSolved';
  static const String UserPending = '/UserPending';
  static const String UserSubmitted = '/UserSubmitted';
  static const String GetFlashcards = '/api/flashcard/GetFlashcards';
  //bundles endpoints
  static const String GetBundles = '/api/bundle/';
  static const String PurchaseBundles = '/api/purchase/Bundle';
  static const String CouponCode = '/VerifyCouponCode';

  //FCMTokens

  static const String SaveFCMToken = '/api/appNotifications/saveFCMToken';
  static const String DeleteFCMToken = '/api/appNotifications/deleteFCMToken';

  //update account details
  static const String UpdateAccount = '/UpdateAccountInfo';
  static const String UpdatePassword = '/UpdateAccountPassword';

  static const String GetWebNotifications = '/GetNotifications';
  //stat Points
  static const String UserStatistics = '/api/statistics/compute-statistics';

  //deckPoint
  static const String Deckspoints = '/api/get-all-published-decks';
  static const String getDeckInfo =
      'https://prodapi.premed.pk/api/decks/get-deck-information/';

  static const String sindhPoints = 'Sindh%20MDCAT%202023';

}
