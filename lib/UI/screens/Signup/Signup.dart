// ignore: file_names
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/ui/widgets/google_login_button.dart';
import 'package:premedpk_mobile_app/ui/widgets/or_divider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                SizedBoxes.verticalBig,
                CustomButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExpertSolutionHome(),
                      ),
                    );
                  },
                ),
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
}
