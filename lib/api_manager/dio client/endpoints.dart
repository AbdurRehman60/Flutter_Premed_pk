// ignore_for_file: constant_identifier_names

class Endpoints {
  Endpoints._();

  //Ports
  static const String serverPort = "4002";

  // base url

  //static const String baseUrl = "http://192.168.10.6"; //saad
  static const String baseUrl = "http://192.168.0.106"; //saneha

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

  //mocks

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

  //delete account
  static const String DeleteAccount = '/api/user/DeleteAccount';

  //mdcat nums and pu mocks endpoints
  static const String Deckspoints = '/api/get-category-decks/MDCAT Mocks';
  static const String Privuni =
      '/api/get-category-decks/Private Universities Mocks';
  static const String Nums = '/api/get-category-decks/NUMS Mocks';

  //QbankPoints
  static const String GetmdcatQBank = 'api/get-category-decks/MDCAT QBank';

  //deck point
  static const String getDeckInfo =
      'https://prodapi.premed.pk/api/decks/get-deck-information/';

  static const String getQuestions =
      'https://prodapi.premed.pk/api/decks/get-all-deck-questions/';

  //test_interface
  static const String GetAllDeckQuestions =
      '/api/decks/get-all-deck-questions/NUMS%20Mock%20Paper%202';

  //saved ques

  static const String handleSavedQuestion =
      '/api/saveQuestion/handleSavedQuestion';

  //report ques
  static const String addReport =
      'https://prodapi.premed.pk/api/reports/addReport';

  //user stats
  static const String UserStatistics = '/api/statistics/compute-statistics';
  static const String QuestionOfTheDay = '/api/question/getRandomQuestions';
  static const String RecentActivityURL = '/api/attempts/get-recent-attempts';

  static const String MdcatQbank = '/api/get-category-decks/MDCAT QBank';
  static const String NUMSQbank = '/api/get-category-decks/NUMS QBank';
  static const String PRVUQbank =
      '/api/get-category-decks/Private Universities QBank';

  //for test interface (1/2/3 sets and so on)
  static String questions(int page) => '/api/decks/getlatestdeckquestion/$page';

  //create deck attempt
  static const String DeckAttempt = '/api/attempts/create-deck-attempt';

//update attempt
  static String updateAttempt(String attemptId) =>
      '/api/attempts/update-attempt/$attemptId';

  //update result
  static String updateResult(String attemptId) =>
      '/api/attempts/update-result/$attemptId';

  static String getAttemptInfo(String attemptId)=>'/api/attempts/get-attempt-info/$attemptId';
}
