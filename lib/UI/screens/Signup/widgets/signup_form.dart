import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:premedpk_mobile_app/repository/auth_provider.dart';
import 'package:premedpk_mobile_app/repository/user_provider.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  // TextEditingController referralCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void onSignupPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        Future<Map<String, dynamic>> response = auth.signup(
          emailController.text,
          passwordController.text,
          fullnameController.text,
          // referralCodeController.text,
        );

        response.then((response) {
          if (response['status']) {
            User user = response['user'];

            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ExpertSolutionHome(),
              ),
            );
          } else {
            showError(context, response);
          }
        });
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
                // ... Your other widgets ...
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(PremedAssets.PrMedLogo),
                ),
                Text(
                  'Start Your path to',
                  style: PreMedTextTheme().heading4.copyWith(
                        color: PreMedColorTheme().neutral600,
                      ),
                ),
                Text(
                  'becoming a Doctor',
                  style: PreMedTextTheme().heading4.copyWith(
                        color: PreMedColorTheme().neutral600,
                      ),
                ),
                SizedBoxes.verticalBig,
                const GoogleLogin(),
                SizedBoxes.verticalBig,
                const OrDivider(),
                SizedBoxes.verticalBig,
                CustomTextField(
                  controller: fullnameController,
                  hintText: 'Full name',
                  labelText: 'John Doe',
                  validator: validateFullname,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  labelText: 'John.Doe@gmail.com',
                  validator: (value) => validateEmail(value),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password*',
                  labelText: 'Enter Password',
                  obscureText: true,
                  validator: validatePassword,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  obscureText: true,
                  validator: validatePassword,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  labelText: 'Referral Code',
                  hintText: 'Enter Referral code',
                  validator: validateReferralCode,
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
                SizedBoxes.verticalBig,
                Text(
                  'By continuing, you agree to Premed.pk’s Terms of Use and Privacy Policy.',
                  style: PreMedTextTheme().subtext.copyWith(
                        color: PreMedColorTheme().neutral500,
                        height: 1.5,
                      ),
                  textAlign: TextAlign.center,
                )
                // ... Your other widgets ...
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateFullname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    return null;
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
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateReferralCode(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.contains(RegExp(r'\d'))) {
      return "Please enter a valid referral code";
    }
    return null;
  }
}
