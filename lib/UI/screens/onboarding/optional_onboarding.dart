import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/curve_painter.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_onboarding_form.dart';
import 'package:premedpk_mobile_app/export.dart';

class OptionalOnboarding extends StatelessWidget {
  const OptionalOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(gradient: PreMedColorTheme().primaryGradient),
        ),
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: CustomPaint(
              painter: CurvePainter(),
            )),
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBoxes.verticalBig,
                  Text(
                    'You are Almost there!',
                    style: PreMedTextTheme()
                        .heading3
                        .copyWith(color: PreMedColorTheme().primaryColorRed),
                  ),
                  SizedBoxes.verticalTiny,
                  Text(
                    'Complete the Final Form and Get Started',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().neutral500),
                  ),
                  SizedBoxes.verticalExtraGargangua,
                  OptionalOnboardingForm(),
                ],
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
