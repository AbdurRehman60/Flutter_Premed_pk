import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../Widgets/global_widgets/custom_button.dart';
import '../../Widgets/global_widgets/custom_textfield.dart';
import '../../Widgets/global_widgets/error_dialogue.dart';
import '../Login/login_screen_one.dart';
import 'additional_info.dart';

class SignUpFlow extends StatefulWidget {
  const SignUpFlow({super.key});

  @override
  State<SignUpFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<SignUpFlow> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  bool hasErrors = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);

    void onSignupPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> signupResponse = auth.signup(
            emailController.text,
            passwordController.text,
            fullNameController.text,
            true
        );

        signupResponse.then((response) {
          if (response['status']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdditionalInfo(),
              ),
            );
          } else {
            showError(context, response);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBoxes.verticalLarge,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBoxes.verticalExtraGargangua,
                              Text(
                                'Sign Up',
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
                                      text: 'A warm welcome to the ',
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
                                      " family! We're delighted to have you here. Let the magic begin!",
                                    ),
                                  ],
                                ),
                              ),
                              SizedBoxes.verticalGargangua,
                              SizedBoxes.verticalBig,
                              CustomTextField(
                                controller: fullNameController,
                                prefixIcon:
                                const Icon(Icons.person_outline_rounded),
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
                                onPressed: () {
                                  onSignupPressed();
                                },
                              ),
                              SizedBoxes.verticalBig,

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: PreMedTextTheme().subtext.copyWith(
                                        fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Sign In',
                                      style: PreMedTextTheme().subtext1.copyWith(
                                          color: PreMedColorTheme().primaryColorRed,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
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
                        ],
                      ),
                    ),
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