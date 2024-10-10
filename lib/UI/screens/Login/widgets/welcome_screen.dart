import 'package:flutter/gestures.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/login_screen_one.dart';
import 'package:premedpk_mobile_app/UI/screens/a_new_signup_flow/signup_choose_emailorggl.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import '../../account/widgets/privacy_policy.dart';
import '../../account/widgets/terms_conditions.dart';
import 'animation_for_welcome_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  double opacity4 = 0.0;
  double opacity5 = 0.0;

  @override
  void initState() {
    super.initState();
    _animateWidgets();
  }

  Future<void> _animateWidgets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacity1 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacity2 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacity3 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacity4 = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacity5 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: PreMedColorTheme().white,
              ),
              child: const RowAnimation(),
            ),
            SizedBoxes.verticalExtraGargangua,
            SizedBoxes.verticalExtraGargangua,
            AnimatedOpacity(
              opacity: opacity1,
              duration: const Duration(milliseconds: 500),
              child: Text(
                "Hi, who dis?",
                style: PreMedTextTheme().heading1.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 34,
                      color: PreMedColorTheme().primaryColorRed,
                    ),
              ),
            ),
            SizedBoxes.vertical2Px,
            AnimatedOpacity(
              opacity: opacity2,
              duration: const Duration(milliseconds: 500),
              child: Text(
                "Welcome to the PreMed App.",
                style: PreMedTextTheme().heading1.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: PreMedColorTheme().black,
                    ),
              ),
            ),
            SizedBoxes.verticalGargangua,
            AnimatedOpacity(
              opacity: opacity3,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "One App to Rule Them All. Yeah, you’ll find all your entry test needs fulfilled by this app!",
                  style: PreMedTextTheme().heading1.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: PreMedColorTheme().black,
                        height: 1.5,
                      ),
                ),
              ),
            ),
            SizedBoxes.verticalExtraGargangua,
            AnimatedOpacity(
              opacity: opacity4,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  child: CustomButton(
                    buttonText: "New Here?",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailorGoogle(),
                        ),
                      );
                    },
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBoxes.vertical26Px,
            AnimatedOpacity(
              opacity: opacity5,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  child: CustomButton(
                    buttonText: "Sign In to Existing Account",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()));
                    },
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: PreMedColorTheme().white,
                    textColor: PreMedColorTheme().primaryColorRed,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().white,
                  ),
                  child: const RowAnimation(),
                ),
                SizedBoxes.verticalLarge,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: PreMedTextTheme().body.copyWith(
                          color: PreMedColorTheme().neutral500,
                        ),
                    children: [
                      TextSpan(
                        text: "By signing in, you agree to our ",
                        style: PreMedTextTheme().body.copyWith(
                            color: PreMedColorTheme().neutral500,
                            fontWeight: FontWeight.w400,
                            fontSize: 11),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: PreMedTextTheme().body1.copyWith(
                            color: PreMedColorTheme().primaryColorRed,
                            fontWeight: FontWeight.w700,
                            fontSize: 11),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyPolicy()));
                          },
                      ),
                      TextSpan(
                        text: " and ",
                        style: PreMedTextTheme().body.copyWith(
                            color: PreMedColorTheme().neutral500,
                            fontWeight: FontWeight.w400,
                            fontSize: 11),
                      ),
                      TextSpan(
                        text: "Terms of Use",
                        style: PreMedTextTheme().body1.copyWith(
                            color: PreMedColorTheme().primaryColorRed,
                            fontWeight: FontWeight.w700,
                            fontSize: 11),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsCondition()));
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
