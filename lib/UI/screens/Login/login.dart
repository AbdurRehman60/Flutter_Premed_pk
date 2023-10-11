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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(PremedAssets.PrMedLogo),
                ),
                SizedBoxes.verticalBig,
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.left,
                  style: PreMedTextTheme()
                      .heading2
                      .copyWith(color: PreMedColorTheme().neutral800),
                ),
                SizedBoxes.verticalMedium,
                Text(
                  'Ready Pursue Your Medical Dreams?',
                  textAlign: TextAlign.left,
                  style: PreMedTextTheme()
                      .subtext
                      .copyWith(color: PreMedColorTheme().neutral500),
                ),
                Text(
                  'Sign in to Continue Your Journey.',
                  textAlign: TextAlign.left,
                  style: PreMedTextTheme()
                      .subtext
                      .copyWith(color: PreMedColorTheme().neutral500),
                ),
                SizedBoxes.verticalExtraGargangua,
                const CustomTextField(
                  labelText: 'Email',
                  hintText: 'John.doe@gmail.com',
                ),
                SizedBoxes.verticalMedium,
                const CustomTextField(
                    labelText: "Password",
                    hintText: "PASSWORD",
                    obscureText: true),
                SizedBoxes.verticalBig,
                CustomButton(
                  buttonText: 'Login',
                  onPressed: onLoginPressed,
                ),
                SizedBoxes.verticalBig,
                const OrDivider(),
                SizedBoxes.verticalLarge,
                const GoogleLogin(),
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  onLoginPressed() {}
}
