import 'package:premedpk_mobile_app/UI/Widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/widgets/forgot_error.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/widgets/forgot_success.dart';
import 'package:premedpk_mobile_app/UI/screens/login/login.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    final TextEditingController emailController = TextEditingController();

    void onResetPasswordPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> response =
        auth.forgotPassword(emailController.text);

        response.then(
              (response) {
            if (response['status']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPasswordSuccess(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPasswordError(
                    errorText: response['message'] ?? 'Error',
                  ),
                ),
              );
            }
          },
        );
      }
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot',
                    style: PreMedTextTheme().heading2.copyWith(
                      color: PreMedColorTheme().primaryColorRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ' Password?',
                    style: PreMedTextTheme().heading2.copyWith(
                      color: PreMedColorTheme().black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBoxes.verticalMedium,
              Text(
                "Don’t worry, we got you! Just enter the email associated with your account and we’ll send you instructions to reset your password!",
                textAlign: TextAlign.center,
                style: PreMedTextTheme().subtext.copyWith(
                  color: PreMedColorTheme().black,
                ),
              ),
              SizedBoxes.verticalBig,
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBoxes.verticalMicro,
                    CustomTextField(
                      controller: emailController,
                      prefixIcon: const Icon(Icons.mail_outline),
                      labelText: 'Email address',
                      hintText: 'Enter your email',
                    ),
                    SizedBoxes.verticalBig,
                    Center(
                      child: Column(
                        children: [
                          CustomButton(
                            buttonText: 'Send Email',
                            onPressed: onResetPasswordPressed,
                          ),
                          SizedBoxes.verticalTiny,
                          CustomButton(
                            buttonText: 'Cancel',
                            color: PreMedColorTheme().white,
                            textColor: PreMedColorTheme().primaryColorRed,
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
