class Endpoints {
  Endpoints._();

  //Ports
  static const String serverPort = "4002";

  // base url

  //static const String baseUrl = "http://192.168.10.6"; //saad
  static const String baseUrl = "http://192.168.0.106"; //saneha

  //specific URLs
  // static const String serverURL = "${baseUrl}:${serverPort}";

  //current
  static const String serverURL = "https://app.premed.pk";

  //adminportal
  // static const String serverURL = "https://premed-server.parho.io";

  //web
  // static const String serverURL = "https://production-server.premed.pk";


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
  static const String DoubtUpload = '/api/expert-solutions/doubt-upload';
  static const String UserSolved = 'api/expert-solutions/user-solved';
  static const String RateDoubt = '/RateUser';

  // static const String UserSolved = '/UserSolved';
  static const String UserPending = '/api/expert-solutions/user-pending';
  static const String UserSubmitted = '/api/expert-solutions/user-submitted';

  static const String GetFlashcards = '/api/flashcard/get-flashcards';

  //bundles endpoints
  static const String GetBundles = '/api/bundle/';
  static const String PurchaseBundles = '/api/purchase/Bundle';
  static String CouponCode(String couponcode) => '/api/coupons/verify-coupon-code/$couponcode';



  //FCMTokens

  static const String SaveFCMToken = '/api/appNotifications/saveFCMToken';
  static const String DeleteFCMToken = '/api/appNotifications/deleteFCMToken';

  //update account details
  static const String UpdateAccount = '/UpdateAccountInfo';
  static const String UpdatePassword = '/update-password';

  static const String GetWebNotifications = '/api/notifications/get-notifications';

  //delete account
  static const String DeleteAccount = '/api/user/DeleteAccount';

  //mdcat nums and pu mocks endpoints
  static const String MdCatMocks =
      '/api/categories/get-category-decks/MDCAT Mocks';

  static const String Privuni =
      '/api/categories/get-category-decks/Private Universities Mocks';

  static const String Nums = '/api/categories/get-category-decks/NUMS Mocks';

  //QbankPoints
  static const String GetmdcatQBank = 'api/get-category-decks/MDCAT QBank';

  //deck point
  static const String getDeckInfo =
      'https://app.premed.pk/api/decks/get-deck-information';

  static const String getQuestions =
      'https://app.premed.pk/api/decks/get-all-deck-questions/';

  //test_interface
  static const String GetAllDeckQuestions =
      '/api/decks/get-all-deck-questions/NUMS%20Mock%20Paper%202';

  //saved ques

  static const String handleSavedQuestion =
      '/api/saveQuestion/handleSavedQuestion';
  static const String HandleFlashCard = '/api/flashcard/handleFlashcards';

  //report ques
  static const String addReport =
      'https://app.premed.pk/api/reports/addReport';

  //publishedDecks
  static const String PublishedDecks = '/api/categories/get-all-published-decks';

  //user stats
  static const String UserStatistics = '/api/statistics/compute-statistics';
  static const String QuestionOfTheDay = '/api/question/getRandomQuestions';
  static const String RecentActivityURL = '/api/attempts/get-recent-attempts';

  static const String RecentAttempts =
      'https://app.premed.pk/api/attempts/get-recent-attempts';

  static const String MdcatQbank =
      '/api/categories/get-category-decks/MDCAT QBank';
  static const String NUMSQbank =
      '/api/categories/get-category-decks/NUMS QBank';
  static const String PRVUQbank =
      '/api/categories/get-category-decks/Private Universities QBank';

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

  static String getAttemptInfo(String attemptId) =>
      '/api/attempts/get-attempt-info/$attemptId';

  static const String attemptPoints =
      'https://app.premed.pk/api/attempts/get-latest-attempt';

//vaultEndpoints
  //preMedical =>
  static const String TopicalNotes =
      '/api/topicalguides/get/ENTRANCE EXAM/PRE-MEDICAL';
  static const String CheatSheets =
      '/api/vault/cheatSheets/get/ENTRANCE EXAM/PRE-MEDICAL';
  static const String ShortListings =
      '/api/vault/shortListings/get/ENTRANCE EXAM/PRE-MEDICAL';
  static const String StudyNotes =
      '/api/vault/notes/get/ENTRANCE EXAM/PRE-MEDICAL';
  static const String topicalguides =
      '/api/topicalguides/get/ENTRANCE EXAM/PRE-MEDICAL';
  static const String EssentialStuff =
      '/api/essential/get/ENTRANCE EXAM/PRE-MEDICAL';
  static const String Mnemonics =
      '/api/mnemonics/getAll/ENTRANCE EXAM/PRE-MEDICAL';

  //preEngineering =>
  static const String EngineeringStudyNotes =
      '/api/vault/notes/get/ENTRANCE EXAM/PRE-ENGINEERING';
  static const String EngineeringEssentialStuff =
      '/api/essential/get/ENTRANCE EXAM/PRE-ENGINEERING';

  //VaultEnded
  static const String handleCards = '/api/flashcard/handleFlashcards';
  static const String SavedQuestions = '/api/saveQuestion/get-saved-questions';

  static const String getPapers =
      '/api/decks/get-mdcat-deck-information';

  static const String boardsandfeatures = 'https://production-server.premed.pk/api/packages/get-boards-and-features';

  static  String getdeckinfothrudeckname (String deckname)  =>'/api/decks/get-deck-information/$deckname';
}
