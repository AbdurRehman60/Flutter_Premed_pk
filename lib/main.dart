import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/tab_bar.dart';
import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/spalsh_screen.dart';
import 'package:premedpk_mobile_app/constants/premed_theme.dart';
import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/spalsh_screen.dart';
import 'export.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/bottom_navbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  PreMedTheme _PreMedTheme = PreMedTheme();

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