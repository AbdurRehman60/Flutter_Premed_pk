import 'package:premedpk_mobile_app/UI/screens/Login/login.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class ForgotPasswordSuccess extends StatelessWidget {
  const ForgotPasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: PreMedColorTheme().customCheckboxColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: PreMedColorTheme().tickcolor, width: 3)),
                    child: Icon(
                      Icons.check,
                      color: PreMedColorTheme().tickcolor,
                      size: 30,
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  Text(
                    'Email Sent',
                    style: PreMedTextTheme().heading2.copyWith(
                      color: PreMedColorTheme().primaryColorRed,
                      fontWeight: FontWeight.w800,
                      fontSize: 34,
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  Text(
                    textAlign: TextAlign.center,
                    "Check your email for instructions to reset your password.",
                    style: PreMedTextTheme().subtext.copyWith(
                      color: PreMedColorTheme().black,
                    ),
                  ),
                  SizedBoxes.verticalBig,
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Note',
                          style: PreMedTextTheme().subtext.copyWith(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: PreMedColorTheme().black,
                          ),
                        ),
                        TextSpan(
                          text:
                          ', you will only receive an email if you have a PreMed account.',
                          style: PreMedTextTheme().subtext.copyWith(
                            fontStyle: FontStyle.italic,
                            color: PreMedColorTheme().black,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBoxes.verticalBig,
                  CustomButton(buttonText: 'Done', onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
