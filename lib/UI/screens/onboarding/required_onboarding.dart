import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/required_onboarding_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/ui/screens/onboarding/widgets/curve_painter.dart';


class RequiredOnboarding extends StatelessWidget {
  const RequiredOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBoxes.verticalExtraGargangua,
                      Column(
                        children: [
                          SizedBoxes.verticalExtraGargangua,
                          Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: PreMedTextTheme()
                                .heading1
                                .copyWith(color: PreMedColorTheme().primaryColorRed),
                          ),
                          SizedBoxes.verticalTiny,
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: PreMedTextTheme().subtext.copyWith(color: PreMedColorTheme().black),
                              children: [
                                TextSpan(
                                  text: 'A warm welcome to the ',
                                ),
                                TextSpan(
                                  text: 'Pre',
                                  style: PreMedTextTheme().subtext1,
                                ),
                                TextSpan(
                                  text: 'M',
                                  style: PreMedTextTheme().subtext1.copyWith(color: PreMedColorTheme().primaryColorRed),
                                ),
                                TextSpan(
                                  text: 'ed',
                                  style: PreMedTextTheme().subtext1,
                                ),
                                TextSpan(
                                  text:  ' family! We\'re delighted to have you here. Let the magic begin!',
                                ),
                              ],
                            ),
                          ),
                      SizedBoxes.verticalExtraGargangua,
                      const RequiredOnboardingForm(),
                    ],
                  ),
                    ]
                ),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}
