import 'package:premedpk_mobile_app/UI/screens/Signup/signup1.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/forgot_password.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
import 'package:premedpk_mobile_app/UI/screens/signup/signup.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/hubspot_help.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void onLoginPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> response = auth.login(
          emailController.text,
          passwordController.text,
        );
        response.then(
          (response) {
            if (response['status']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => response['message'] == 'onboarding'
                      ? const RequiredOnboarding()
                      : const MainNavigationScreen(),
                ),
              );
            } else {
              showError(context, response);
            }
          },
        );
      }
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Column(
              children: [
                SizedBoxes.verticalBig,
                Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: PreMedTextTheme()
                      .heading1
                      .copyWith(color: PreMedColorTheme().primaryColorRed),
                ),
                SizedBoxes.verticalTiny,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: PreMedTextTheme().subtext.copyWith(color: PreMedColorTheme().black),
                    children: [
                      TextSpan(
                        text: 'Welcome back to ',
                      ),
                      TextSpan(
                        text: 'Pre',
                        style: PreMedTextTheme().subtext1,
                      ),
                      TextSpan(
                        text: 'M',
                        style: PreMedTextTheme().subtext1.copyWith(color: PreMedColorTheme().primaryColorRed),
                      ),
                      TextSpan(
                        text: 'ed',
                        style: PreMedTextTheme().subtext1,
                      ),
                      TextSpan(
                        text: '! Where’ve you been? Let’s resume your journey!',
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalExtraGargangua,
                CustomTextField(

                  controller: emailController,
                  prefixIcon: Icon(Icons.mail_outline),
                  labelText: 'Email address',
                  hintText: 'Enter your email',
                  validator: (value) => validateEmail(value),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: passwordController,
                  prefixIcon: Icon(Icons.lock_outline),
                  labelText: "Password",
                  hintText: "Enter your password",
                  obscureText: true,
                  validator: (value) => validatePassword(value),
                ),
                SizedBoxes.verticalBig,
                if (auth.loggedInStatus == Status.Authenticating) ...{
                  SizedBoxes.verticalBig,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                      SizedBoxes.horizontalMedium,
                      Text(
                        'Logging in',
                        style: PreMedTextTheme().subtext,
                      ),
                    ],
                  ),
                  SizedBoxes.verticalLarge,
                } else ...{
                  CustomButton(
                    buttonText: 'Sign In',
                    onPressed: onLoginPressed,

                  ),
                  SizedBoxes.verticalMicro,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          'Forgot Password?',
                          style: PreMedTextTheme().subtext.copyWith(
                            color: PreMedColorTheme().neutral600,
                            fontWeight: FontWeights.regular,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: PreMedTextTheme().subtext,
                      ),
                      TextButton(
                        child: Text(
                          'Sign Up',
                          style: PreMedTextTheme().subtext1.copyWith(
                              color: PreMedColorTheme().primaryColorRed),
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
                  SizedBox(height: 80,),
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
                          ),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: PreMedTextTheme().body1.copyWith(
                            color: PreMedColorTheme().neutral500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy() ));
                            },
                        ),
                        TextSpan(
                          text: " and ",
                          style: PreMedTextTheme().body.copyWith(
                            color: PreMedColorTheme().neutral500,
                          ),
                        ),
                        TextSpan(
                          text: "Terms of Use",
                          style: PreMedTextTheme().body1.copyWith(
                              color: PreMedColorTheme().neutral500
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TermsCondition() ));
                            },
                        ),
                      ],
                    ),
                  ),
                }
              ],
            ),
          ],
        ),
      ),
    );
  }


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }
}
