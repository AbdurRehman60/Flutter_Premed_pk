import 'package:premedpk_mobile_app/UI/screens/forgot_password/forgot_password.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
import 'package:premedpk_mobile_app/UI/screens/signup/signup.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/hubspot_help.dart';
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
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Ready to Pursue Your Medical Dreams?',
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
                CustomTextField(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  validator: (value) => validateEmail(value),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: passwordController,
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
                    buttonText: 'Login',
                    onPressed: onLoginPressed,
                  ),
                  SizedBoxes.verticalMicro,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: Text(
                          'I forgot my password.',
                          style: PreMedTextTheme()
                              .subtext
                              .copyWith(color: PreMedColorTheme().neutral400),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const OrDivider(),
                  SizedBoxes.verticalLarge,
                  const GoogleLogin(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: PreMedTextTheme().subtext,
                      ),
                      TextButton(
                        child: Text(
                          'SignUp',
                          style: PreMedTextTheme().subtext.copyWith(
                              color: PreMedColorTheme().primaryColorRed),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                },
                const HubspotHelpButton(),
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
