import 'package:premedpk_mobile_app/UI/screens/Login/animation.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/login.dart';
import 'package:premedpk_mobile_app/UI/screens/Signup/signup_screen_one.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/hubspot_help.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 240,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: PreMedColorTheme().white,
                        ),
                        child: const MovingRowAnimation()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        children: [
                          SizedBoxes.verticalBig,
                          Column(
                            children: [
                              SizedBoxes.verticalBig,
                              Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: PreMedTextTheme().heading1.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 34,
                                    color: PreMedColorTheme().primaryColorRed),
                              ),
                              SizedBoxes.verticalTiny,
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: PreMedTextTheme().subtext.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: PreMedColorTheme().black),
                                  children: [
                                    const TextSpan(
                                      text: 'Welcome back to ',
                                    ),
                                    TextSpan(
                                      text: 'Pre',
                                      style: PreMedTextTheme().subtext1,
                                    ),
                                    TextSpan(
                                      text: 'M',
                                      style: PreMedTextTheme()
                                          .subtext1
                                          .copyWith(
                                              color: PreMedColorTheme()
                                                  .primaryColorRed),
                                    ),
                                    TextSpan(
                                      text: 'ed',
                                      style: PreMedTextTheme().subtext1,
                                    ),
                                    const TextSpan(
                                      text:
                                          '! Where’ve you been? Let’s resume your journey!',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBoxes.verticalExtraGargangua,
                         GoogleLogin(),
                          SizedBoxes.verticalBig,
                          const Padding(
                            padding: EdgeInsets.only(left: 64, right: 64),
                            child: OrDivider(),
                          ),
                          SizedBoxes.verticalBig,
                          Center(
                            child: SizedBox(
                              width: buttonSize,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PreMedColorTheme().white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 3,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.mail_outline,
                                              color: PreMedColorTheme().black,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'Sign in with Email',
                                                textAlign: TextAlign.center,
                                                style:
                                                    PreMedTextTheme().subtext,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBoxes.verticalTiny,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: PreMedTextTheme().subtext.copyWith(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                              TextButton(
                                child: Text(
                                  'Sign Up',
                                  style: PreMedTextTheme().subtext1.copyWith(
                                      color: PreMedColorTheme().primaryColorRed,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignUp(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const HubspotHelpButton(),
          ],
        ),
      ),
    );
  }
}
