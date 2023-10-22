import 'package:camera/camera.dart';
import 'package:premedpk_mobile_app/repository/auth_provider.dart';
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
  // MyApp({super.key});
  final PreMedTheme _PreMedTheme = PreMedTheme();

  MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _PreMedTheme.data,
        home: const Login(),
      ),
    );
  }
}
