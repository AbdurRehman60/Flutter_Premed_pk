import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/ui/widgets/or_divider.dart';

import '../../widgets/google_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 400,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              gradient: PreMedColorTheme().primaryGradient,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Sign Up to get Province',
                textAlign: TextAlign.center,
                style: PreMedTextTheme()
                    .heading3
                    .copyWith(color: PreMedColorTheme().white),
              ),
              Text(
                'wise Chapter guides for FREE!',
                textAlign: TextAlign.center,
                style: PreMedTextTheme()
                    .heading3
                    .copyWith(color: PreMedColorTheme().white),
              ),
              SizedBoxes.verticalBig,
              Image.asset('assets/images/Books.png'),
            ]),
          ),
          const LoginForm(),
        ]),
      ),
    ));
  }

  onLoginPressed() {}
}
