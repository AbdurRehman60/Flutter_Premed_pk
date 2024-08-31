import 'package:flutter/gestures.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/widgets/welcome_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/forgot_password.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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
              showError(
                context,
                {"message": "You are already logged in on another device."},
              );
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
                        style: PreMedTextTheme().subtext1.copyWith(
                            color: PreMedColorTheme().primaryColorRed),
                      ),
                      TextSpan(
                        text: 'ed',
                        style: PreMedTextTheme().subtext1,
                      ),
                      const TextSpan(
                        text: '! Where’ve you been? Let’s resume your journey!',
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalExtraGargangua,
                CustomTextField(
                  controller: emailController,
                  prefixIcon: const Icon(Icons.mail_outline),
                  labelText: 'Email address',
                  hintText: 'Enter your email',
                  validator: (value) => validateEmail(value),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: passwordController,
                  prefixIcon: const Icon(Icons.lock_outline),
                  labelText: "Password",
                  hintText: "Enter your password",
                  obscureText: true,
                  validator: (value) => validatePassword(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'Forgot Password?',
                        style: PreMedTextTheme().subtext.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.5,
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
                              fontSize: 14.5),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WelcomeScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
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
                              color: PreMedColorTheme().neutral500,
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
                              color: PreMedColorTheme().neutral500,
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
