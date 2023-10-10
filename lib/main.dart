import 'package:premedpk_mobile_app/constants/premed_theme.dart';

import 'export.dart';

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
      home: RequiredOnboarding(),
    );
  }
}
