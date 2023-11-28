import 'package:camera/camera.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/checkout.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/payment_tile.dart';
import 'package:premedpk_mobile_app/UI/test.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/providers/flashcard_provider.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'export.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final PreMedTheme _PreMedTheme = PreMedTheme();

  MyApp({super.key});
  // This widget is the root of your application.
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
      ],
      child: MaterialApp(
          routes: {
            '/ExpertSolution': (context) => const AskanExpert(),
          },
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: _PreMedTheme.data,
          home: Checkout()

          //  PaymentTile(
          //   selected: true,
          //   paymentProvider: 'Bank Transfer',
          //   image: PremedAssets.JazzCash,
          //   numbers: numbers,
          // ),
          ),
    );
  }
}

final Map<String, dynamic> numbers = {
  'Muhammad Uzair': '0333-3324911',
  'Fahad Niaz Sheikh': '0325-6064069',
  'Niaz Hussain': '0336-2542685',
};
