import 'package:premedpk_mobile_app/UI/Widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:premedpk_mobile_app/repository/auth_provider.dart';
import 'package:premedpk_mobile_app/repository/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:premedpk_mobile_app/export.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    onLoginPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> response =
            auth.login(emailController.text, passwordController.text);

        response.then(
          (response) {
            if (response['status']) {
              // User user = response['user'];

              // Provider.of<UserProvider>(context, listen: false).setUser(user);

              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SignUpScreen(),
              //   ),
              // );
            } else {
              showError(context, response);
            }
            // Add this line to print status code
          },
        );
      }
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  validator: (value) =>
                      validateEmail(value), // Use the email validator
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: passwordController,
                  labelText: "Password",
                  hintText: "Enter your password",
                  obscureText: true,
                  validator: (value) =>
                      validatePassword(value), // Use the password validator
                ),
                SizedBoxes.verticalBig,
                CustomButton(buttonText: 'Login', onPressed: onLoginPressed),
                SizedBoxes.verticalBig,
                const OrDivider(),
                SizedBoxes.verticalLarge,
                const GoogleLogin(),
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
