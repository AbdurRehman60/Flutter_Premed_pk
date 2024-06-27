import 'package:premedpk_mobile_app/constants/constants_export.dart';

import 'animation_for_welcome_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: PreMedColorTheme().white,
          ),
          child: const RowAnimation()),
    ])));
  }
}
