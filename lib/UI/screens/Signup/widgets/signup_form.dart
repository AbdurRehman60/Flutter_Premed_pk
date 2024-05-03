import 'package:premedpk_mobile_app/UI/screens/Login/login_screen_one.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/optional_onboarding.dart';
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
    final AuthProvider auth = Provider.of<AuthProvider>(context);

    void onSignupPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> response = auth.signup(
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
                  builder: (context) => const OptionalOnboarding(),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: [
                //SizedBoxes.verticalBig,
                Column(
                  children: [
                    Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: PreMedTextTheme()
                          .heading1
                          .copyWith(color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.w800,
                      fontSize: 34),
                    ),
                    SizedBoxes.verticalTiny,
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: PreMedTextTheme().subtext.copyWith(color: PreMedColorTheme().black, fontSize: 14, fontWeight: FontWeight.w400),
                        children: [
                          const TextSpan(
                            text: 'A warm welcome to the ',
                          ),
                          TextSpan(
                            text: 'Pre',
                            style: PreMedTextTheme().subtext1.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          TextSpan(
                            text: 'M',
                            style: PreMedTextTheme().subtext1.copyWith(color: PreMedColorTheme().primaryColorRed,fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          TextSpan(
                            text: 'ed',
                            style: PreMedTextTheme().subtext1.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          const TextSpan(
                            text:  " family! We're delighted to have you here. Let the magic begin!",
                          ),
                        ],
                      ),
                    ),
                    SizedBoxes.verticalGargangua,
                    CustomTextField(
                      controller: fullNameController,
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      hintText: 'Enter your full name',
                      labelText: 'Full Name',
                      validator: validateFullname,
                    ),
                    SizedBoxes.verticalBig,
                    CustomTextField(
                      controller: emailController,
                      prefixIcon: const Icon(Icons.mail_outline),
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      validator: (value) => validateEmail(value),
                    ),
                    SizedBoxes.verticalBig,
                    CustomTextField(
                      controller: passwordController,
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      obscureText: true,
                      validator: validatePassword,
                    ),
                    SizedBoxes.verticalBig,
                    CustomTextField(
                      controller: confirmPasswordController,
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'Re-enter your password',
                      labelText: 'Confirm Password',
                      obscureText: true,
                      validator: validatePassword,
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
                          "Already have an account?",
                          style: PreMedTextTheme().subtext.copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        TextButton(
                          child: Text(
                            'Sign In',
                            style: PreMedTextTheme().subtext1.copyWith(color: PreMedColorTheme().primaryColorRed, fontWeight: FontWeight.w700, fontSize: 14),
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
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }

  String? validateFullname(String? value) {
    if (value == null || value.isEmpty) {
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
