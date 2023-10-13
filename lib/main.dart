import 'package:camera/camera.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/expert_solution.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/tab_bar.dart';
import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/spalsh_screen.dart';
import 'package:premedpk_mobile_app/constants/premed_theme.dart';
import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/spalsh_screen.dart';
import 'export.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/bottom_navbar.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/camera_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  // MyApp({super.key});
  PreMedTheme _PreMedTheme = PreMedTheme();

  final CameraDescription camera;

  MyApp({required this.camera});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _PreMedTheme.data,
        home: ExpertSolution(
          camera: camera,
        ));
  }
}

//test