import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../Widgets/global_widgets/custom_textfield.dart';
import '../../Widgets/global_widgets/error_dialogue.dart';
import '../onboarding/optional_onboarding.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({required this.lastOnboardingPage, super.key});
  final String lastOnboardingPage;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
        final Future<Map<String, dynamic>> signupResponse = auth.signup(
          emailController.text,
          passwordController.text,
          fullNameController.text,
        );

        signupResponse.then((response) {
          if (response['status']) {
            final Future<Map<String, dynamic>> onboardingResponse = auth.requiredOnboarding(
              username: emailController.text,
              lastOnboardingPage: widget.lastOnboardingPage,
            );

            onboardingResponse.then((onboardingResponse) {
              if (onboardingResponse['status']) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OptionalOnboarding(),
                  ),
                );
              } else {
                showError(context, onboardingResponse);
              }
            });
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Let’s Get\nStarted!',
                              textAlign: TextAlign.left,
                              style: PreMedTextTheme().heading1.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 35),
                            ),
                            SizedBoxes.verticalMedium,
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: PreMedTextTheme().subtext.copyWith(
                                    color: PreMedColorTheme().black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800),
                                children: [
                                  const TextSpan(
                                    text: 'Hi, what’s your ',
                                  ),
                                  TextSpan(
                                    text: 'name',
                                    style: PreMedTextTheme().subtext1.copyWith(
                                        color: PreMedColorTheme().primaryColorRed,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25),
                                  ),
                                  TextSpan(
                                    text: '?',
                                    style: PreMedTextTheme().subtext1.copyWith(
                                        fontWeight: FontWeight.w800, fontSize: 25),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: PreMedColorTheme().primaryColorRed200, width: 6),
                ),
                child: CircleAvatar(
                  backgroundColor: PreMedColorTheme().neutral60,
                  radius: 20,
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 28,
                    color: PreMedColorTheme().primaryColorRed,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: onSignupPressed,
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: PreMedColorTheme().bordercolor, width: 6),
                ),
                child: CircleAvatar(
                  backgroundColor: PreMedColorTheme().primaryColorRed,
                  radius: 28,
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 34,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
