import 'package:camera/camera.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/es_home.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/es_list_card.dart';
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
      // home: const CardList(
      //   mainText:
      //       'Identify the sentence with the incorrect use of apostrophe from the following sentences and tell the ans',
      //   tags: [
      //     {"tagName": "Tag1", "isResource": true},
      //     {"tagName": "Tag2", "isResource": true},
      //     {"tagName": "tag3", "isResource": false},
      //     {"tagName": "tag1234567891011121", "isResource": false},
      //     {"tagName": "tag3", "isResource": false},
      //     {"tagName": "tag3", "isResource": false},
      //     {"tagName": "tag3", "isResource": false},
      //     {"tagName": "tag3", "isResource": false},
      //     {"tagName": "tag3", "isResource": false},
      //   ],
      //   subtext:
      //       'I cant understand the questiona nd the options provided. Please help me my paper is in 3 days. I need to Complete this mock.',
      // ));
      home: ExpertSolution(),
    );
  }
}

//test