import 'package:premedpk_mobile_app/UI/screens/Signup/Signup.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/On_Boarding.dart';
import 'package:premedpk_mobile_app/export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: OnBoarding(),
    );
  }
}
