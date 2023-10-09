// ignore: file_names
import 'package:premedpk_mobile_app/export.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset('assets/images/PreMedLogo.png')),
                Text(
                  'Start Your path to becoming a Doctor',
                  style: PreMedTextTheme()
                      .heading4
                      .copyWith(color: PreMedColorTheme().black),
                ),
                // signup with google button to be added once finished
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(
                      color: PreMedColorTheme().black,
                      thickness: 2,
                    ),
                    const Text('OR'),
                    Divider(
                      color: PreMedColorTheme().black,
                      thickness: 2,
                    )
                  ],
                ),
                SizedBoxes.verticalBig,
                const CustomTextField(
                  hintText: 'Full name',
                  labelText: 'John Doe',
                ),
                SizedBoxes.verticalMedium,
                const CustomTextField(
                  hintText: 'Email',
                  labelText: 'John.Doe@gmail.com',
                ),
                SizedBoxes.verticalMedium,
                const CustomTextField(
                  hintText: 'Password*',
                  labelText: 'Enter Password',
                  obscureText: true,
                ),
                SizedBoxes.verticalMedium,
                const CustomTextField(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBoxes.verticalMedium,
                const CustomTextField(
                  hintText: 'Referral Code (optional)',
                  labelText: 'Enter Referral Code if you have any',
                ),
                SizedBoxes.verticalMedium,
                CustomButton(buttonText: 'Sign Up', onPressed: () {}),
                SizedBoxes.verticalMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: PreMedTextTheme().subtext
                        // .copyWith(color: PreMedColorTheme().black),
                        ),
                    SizedBoxes.horizontalMicro,
                    Text(
                      'Signup',
                      style: PreMedTextTheme()
                          .subtext
                          .copyWith(color: PreMedColorTheme().primaryColorRed),
                    ),
                  ],
                ),
                SizedBoxes.verticalBig,
                Text(
                  'By continuing, you agree to Premed.pk’s Terms of Use and Privacy Policy.',
                  style: PreMedTextTheme()
                      .subtext
                      .copyWith(color: PreMedColorTheme().neutral500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
