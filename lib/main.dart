import 'package:camera/camera.dart';
import 'package:premedpk_mobile_app/constants/premed_theme.dart';
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
  // MyApp({super.key});
  PreMedTheme _PreMedTheme = PreMedTheme();

  MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _PreMedTheme.data,
        home: EsHome());
  }
}

//test