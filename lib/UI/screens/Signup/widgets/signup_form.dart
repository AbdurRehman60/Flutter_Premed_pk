import 'package:premedpk_mobile_app/UI/widgets/hubspot_help.dart';
import 'package:premedpk_mobile_app/UI/screens/login/login.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';

import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void onSignupPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        Future<Map<String, dynamic>> response = auth.signup(
          emailController.text,
          passwordController.text,
          fullNameController.text,
          referralCodeController.text,
        );

        response.then(
          (response) {
            if (response['status']) {
              // User user = response['user'];

              // Provider.of<UserProvider>(context, listen: false).setUser(user);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RequiredOnboarding(),
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
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(PremedAssets.PrMedLogo),
                ),
                Text(
                  'Start Your path to',
                  style: PreMedTextTheme().heading4.copyWith(
                        color: PreMedColorTheme().neutral900,
                      ),
                ),
                Text(
                  'becoming a Doctor',
                  style: PreMedTextTheme().heading4.copyWith(
                        color: PreMedColorTheme().neutral900,
                      ),
                ),
                SizedBoxes.verticalBig,
                const GoogleLogin(),
                SizedBoxes.verticalBig,
                const OrDivider(),
                SizedBoxes.verticalBig,
                CustomTextField(
                  controller: fullNameController,
                  hintText: 'Enter your full name',
                  labelText: 'Full Name',
                  validator: validateFullname,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  validator: (value) => validateEmail(value),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: confirmEmailController,
                  hintText: 'Re-enter your email',
                  labelText: 'Confirm Email',
                  validator: (value) => validateConfirmEmail(value),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  obscureText: true,
                  validator: validatePassword,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: 'Re-enter your password',
                  labelText: 'Confirm Password',
                  obscureText: true,
                  validator: validatePassword,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  labelText: 'Referral Code (Optional)',
                  hintText: 'Enter Referral code',
                  controller: referralCodeController,
                ),
                SizedBoxes.verticalMedium,
                CustomButton(
                  buttonText: 'Sign Up',
                  onPressed: onSignupPressed,
                ),
                SizedBoxes.verticalMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: PreMedTextTheme().subtext,
                    ),
                    SizedBoxes.horizontalMicro,
                    TextButton(
                      child: Text(
                        'Login',
                        style: PreMedTextTheme().subtext.copyWith(
                            color: PreMedColorTheme().primaryColorRed),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const HubspotHelpButton(),
                SizedBoxes.verticalMedium,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'By continuing, you agree to Premed.pk’s  Terms of Use and Privacy Policy.',
                    style: PreMedTextTheme().subtext.copyWith(
                          fontSize: 12,
                          color: PreMedColorTheme().neutral500,
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateFullname(String? value) {
    if ((value == null || value.isEmpty)) {
      return 'Full name is required';
    } else if (value.length < 3) {
      return 'Incorrect name length';
    } else if (value.contains(RegExp(r'[0-9]'))) {
      return 'Full name should not contain numbers';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@') || !value.contains('com')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateConfirmEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Email is required';
    } else if (!value.contains('@') || !value.contains('com')) {
      return 'Invalid email format';
    } else if (emailController.text != value) {
      return "Emails don't match";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
