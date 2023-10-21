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

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fullnameController = TextEditingController();

    void onSignupPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        Future<Map<String, dynamic>> response = auth.signup(
          emailController.text,
          passwordController.text,
          fullnameController.text,
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
                  hintText: 'Full name',
                  labelText: 'John Doe',
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  hintText: 'Email',
                  labelText: 'John.Doe@gmail.com',
                  validator: (value) => validateEmail(value),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  hintText: 'Password*',
                  labelText: 'Enter Password',
                  obscureText: true,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  hintText: 'Referral Code (optional)',
                  labelText: 'Enter Referral Code if you have any',
                ),
                SizedBoxes.verticalBig,
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
                    Text(
                      'Login',
                      style: PreMedTextTheme()
                          .subtext
                          .copyWith(color: PreMedColorTheme().primaryColorRed),
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
              ],
            ),
          ),
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
