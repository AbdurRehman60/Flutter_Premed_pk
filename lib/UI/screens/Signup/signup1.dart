import 'package:premedpk_mobile_app/UI/Widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/login.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/signin.dart';
import 'package:premedpk_mobile_app/UI/screens/Signup/Signup.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/hubspot_help.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width * 0.7;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: PreMedColorTheme().white,
              ),
              child: Image.asset('assets/images/chips.png', fit: BoxFit.cover),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Column(children: [
                    SizedBoxes.verticalBig,
                    Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: PreMedTextTheme()
                          .heading1
                          .copyWith(color: PreMedColorTheme().primaryColorRed),
                    ),
                    SizedBoxes.verticalTiny,
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: PreMedTextTheme()
                            .subtext
                            .copyWith(color: PreMedColorTheme().black),
                        children: [
                          TextSpan(
                            text: 'A warm welcome to the ',
                          ),
                          TextSpan(
                            text: 'Pre',
                            style: PreMedTextTheme().subtext1,
                          ),
                          TextSpan(
                            text: 'M',
                            style: PreMedTextTheme().subtext1.copyWith(
                                color: PreMedColorTheme().primaryColorRed),
                          ),
                          TextSpan(
                            text: 'ed',
                            style: PreMedTextTheme().subtext1,
                          ),
                          TextSpan(
                            text:
                                ' family! We\'re delighted to have you here. Let the magic begin!',
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBoxes.verticalExtraGargangua,
                  GoogleLogin(),
                  SizedBoxes.verticalBig,
                  const OrDivider(),
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
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PreMedColorTheme().white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        'Sign Up with Email',
                                        textAlign: TextAlign.center,
                                        style: PreMedTextTheme().subtext,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: PreMedTextTheme().subtext,
                      ),
                      TextButton(
                        child: Text(
                          'Sign In',
                          style: PreMedTextTheme().subtext1.copyWith(
                              color: PreMedColorTheme().primaryColorRed),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 130,
                  ),
                  const HubspotHelpButton(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
