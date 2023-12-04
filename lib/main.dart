import 'package:camera/camera.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/ask_an_expert.dart';
import 'package:premedpk_mobile_app/UI/screens/splash_screen/splash_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final PreMedTheme _PreMedTheme = PreMedTheme();

  MyApp({super.key});

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
      ],
      child: MaterialApp(
        routes: {
          '/ExpertSolution': (context) => const AskanExpert(),
        },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _PreMedTheme.data,
        home: const SplashScreen(),
      ),
    );
  }
}
