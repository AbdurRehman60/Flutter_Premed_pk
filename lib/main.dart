// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/ask_an_expert.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/checkout.dart';
import 'package:premedpk_mobile_app/UI/screens/splash_screen/splash_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

List<CameraDescription> cameras = [];

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
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
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
      ],
      child: MaterialApp(
        routes: {
          '/ExpertSolution': (context) => const AskanExpert(),
          '/Checkout': (context) => const Checkout(),
        },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _preMedTheme.data,
        home: const SplashScreen(),
      ),
    );
  }
}
