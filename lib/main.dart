import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/ask_an_expert.dart';
import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/splash_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/forgot_password.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/widgets/forgot_success.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/checkout.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/pre_engineering/providers/chapterWiseProvider.dart';
import 'package:premedpk_mobile_app/pre_engineering/providers/test_session_proivder.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/providers/create_deck_attempt_provider.dart';
import 'package:premedpk_mobile_app/providers/deck_info_provider.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/info_thru_deckname_provider.dart';
import 'package:premedpk_mobile_app/providers/lastest_attempts_provider.dart';
import 'package:premedpk_mobile_app/providers/mcatqbankprovider.dart';
import 'package:premedpk_mobile_app/providers/mdcat_mocks_provider.dart';
import 'package:premedpk_mobile_app/providers/med_test_session_pro.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:premedpk_mobile_app/providers/nums_mocks_provider.dart';
import 'package:premedpk_mobile_app/providers/nums_qbank_provider.dart';
import 'package:premedpk_mobile_app/providers/onboarding_provider.dart';
import 'package:premedpk_mobile_app/providers/paper_provider.dart';
import 'package:premedpk_mobile_app/providers/pu_mocks_provider.dart';
import 'package:premedpk_mobile_app/providers/pu_qbank_provider.dart';
import 'package:premedpk_mobile_app/providers/question_provider.dart';
import 'package:premedpk_mobile_app/providers/recent_atempts_provider.dart';
import 'package:premedpk_mobile_app/providers/recent_question_pro.dart';
import 'package:premedpk_mobile_app/providers/report_question_provider.dart';
import 'package:premedpk_mobile_app/providers/save_question_provider.dart';
import 'package:premedpk_mobile_app/providers/savedquestion_provider.dart';
import 'package:premedpk_mobile_app/providers/statistic_provider.dart';
import 'package:premedpk_mobile_app/providers/update_attempt_provider.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/cheatsheets_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/eng_study_notes_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/engineering_access_providers.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/essen_stuff_pro.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/essential_stuff_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/mnemonics_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_access_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/shortListing_providers.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/study_guides_prroviderr.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/study_notes_proivders.dart';
import 'package:premedpk_mobile_app/providers/web_notifications_provider.dart';
import 'package:premedpk_mobile_app/utils/services/notifications/firebase_messaging_api.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

List<CameraDescription> cameras = [];
final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    await FirebaseMessagingAPI().initNotifications();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Error in fetching the cameras: $e');
  }
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final PreMedTheme _preMedTheme = PreMedTheme();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(14, 0, 0, 0),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AskAnExpertProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => BundleProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UplaodImageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => WebNotificationsProvider()),
        ChangeNotifierProvider(create: (_) => NumsMocksProvider()),
        ChangeNotifierProvider(create: (_) => PrivuniMocksProvider()),
        ChangeNotifierProvider(create: (_) => MDCATQbankpro()),
        ChangeNotifierProvider(create: (_) => MdcatMocksProviderr()),
        ChangeNotifierProvider(create: (_) => NUMSQbankProvider()),
        ChangeNotifierProvider(create: (_) => PUQbankProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider()),
        ChangeNotifierProvider(create: (_) => CreateDeckAttemptProvider()),
        ChangeNotifierProvider(create: (_) => SaveQuestionProvider()),
        ChangeNotifierProvider(create: (_) => ReportQuestionProvider()),
        ChangeNotifierProvider(create: (_) => AttemptProvider()),
        ChangeNotifierProvider(create: (_) => DeckProvider()),
        ChangeNotifierProvider(create: (_) => RecentAttemptsProvider()),
        ChangeNotifierProvider(create: (_) => UserStatProvider()),
        ChangeNotifierProvider(create: (_) => LatestAttemptPro()),
        ChangeNotifierProvider(create: (_) => ShortListingsProvider()),
        ChangeNotifierProvider(create: (_) => VaultStudyNotesProvider()),
        ChangeNotifierProvider(create: (_) => VaultTopicalGuidesProvider()),
        ChangeNotifierProvider(create: (_) => EssentialStuffProvider()),
        ChangeNotifierProvider(create: (_) => MnemonicsProvider()),
        ChangeNotifierProvider(create: (_) => SavedQuestionsProvider()),
        ChangeNotifierProvider(create: (_) => EngineeringEssentialStuffProvider()),
        ChangeNotifierProvider(create: (_)=> EngineeringStudyNotesProvider()),
        ChangeNotifierProvider(create: (_)=> PreMedProvider()..loadFromPreferences()),
        ChangeNotifierProvider(create: (_)=> EngChapterWisePro()),
        ChangeNotifierProvider(create: (_)=> EngTestSessionsPro()),
        ChangeNotifierProvider(create: (_)=> MedTestSessionsPro()),
        ChangeNotifierProvider(create: (_)=> PreMedAccessProvider()),
        ChangeNotifierProvider(create: (_)=> PreEngAccessProvider()),
        ChangeNotifierProvider(create: (_)=> BoardProvider()),
        ChangeNotifierProvider(create: (_)=> RecQuestionProvider()),
        ChangeNotifierProvider(create: (_)=> PaperProvider()),
        ChangeNotifierProvider(create: (_)=> DeckInfoProvider()),
        ChangeNotifierProvider(create: (_)=> CheatsheetsProvider()),

      ],
      child: MaterialApp(
        routes: {
          '/ExpertSolution': (context) => const AskanExpert(),
          '/Checkout': (context) => const Checkout(),
          '/Marketplace': (context) => const MarketPlace(),
          '/ForgotPasswordSuccess': (context) => const ForgotPasswordSuccess(),
          '/ForgotPasswordError': (context) => const ForgotPassword(),
        },
        title: 'PreMed.PK',
        debugShowCheckedModeBanner: false,
        theme: _preMedTheme.data,
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
