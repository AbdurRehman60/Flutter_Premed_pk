class Endpoints {
  Endpoints._();
  //Ports
  static const String serverPort = "4002";

  // base url
  static const String baseUrl = "http://192.168.100.117"; //saad
  // static const String baseUrl = "http://192.168.10.8"; //ebrahim

  //specific URLs
  static const String serverURL = "${baseUrl}:${serverPort}";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 5000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  static const String login = '/login';
  static const String logout = '/auth/logout';
  static const String signup = '/api/auth/signup';
  static const String OptionalOnboarding = '/api/auth/optional-onboarding';
  static const String RequiredOnboarding = '/api/auth/required-onboarding';
  static const String getLoggedInUser = '/LoggedInUser';
  static const String Guides = '/api/notes/allguides';
  static const String RevisionNotes = '/api/notes/all';
  static const String DoubtUpload = '/DoubtUpload';
  static const String UserSolved = '/UserSolved';
  static const String UserPending = '/UserPending';
  static const String UserSubmitted = '/UserSubmitted';
  static const String GetFlashcards = '/api/flashcard/GetFlashcards';
  static const String GetBundles = '/api/bundle/';
}
