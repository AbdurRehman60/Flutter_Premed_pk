import 'package:premedpk_mobile_app/UI/Widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/widgets/forgot_error.dart';
import 'package:premedpk_mobile_app/UI/screens/forgot_password/widgets/forgot_success.dart';
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
            if (response['status'] == true) {
              print('saad hai1');
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
                  builder: (context) => const ForgotPasswordError(),
                ),
              );
            }
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reset Your Password',
                style: PreMedTextTheme().heading3.copyWith(
                      color: PreMedColorTheme().primaryColorRed,
                    ),
              ),
              SizedBoxes.verticalMedium,
              Text(
                'Please provide the email address \nassociated with your PreMed.PK account.',
                style: PreMedTextTheme().body.copyWith(
                      color: PreMedColorTheme().neutral600,
                    ),
              ),
              SizedBoxes.verticalMedium,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.0, // Border thickness
                  ),
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('E-mail*'),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'baig.ebrahim@gmail.com',
                    ),
                    SizedBoxes.verticalExtraGargangua,
                    // Assuming you have a CustomTextField widget
                    CustomButton(
                      buttonText: 'Reset Password',
                      onPressed: onResetPasswordPressed,
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
