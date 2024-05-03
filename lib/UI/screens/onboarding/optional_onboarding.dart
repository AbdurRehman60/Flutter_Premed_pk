import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/curve_painter.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_onboarding_form.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class OptionalOnboarding extends StatelessWidget {
  const OptionalOnboarding({super.key});

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
                      child: Column(children: [
                        SizedBoxes.verticalExtraGargangua,
                        Column(
                          children: [
                            SizedBoxes.verticalExtraGargangua,
                            Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: PreMedTextTheme().heading1.copyWith(
                                  color: PreMedColorTheme().primaryColorRed,
                                  fontWeight: FontWeight.w800,
                              fontSize: 34),
                            ),
                            SizedBoxes.verticalTiny,
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: PreMedTextTheme().subtext.copyWith(color: PreMedColorTheme().black, fontSize: 14, fontWeight: FontWeight.w400),
                                children: [
                                  const TextSpan(
                                    text: 'A warm welcome to the ',
                                  ),
                                  TextSpan(
                                    text: 'Pre',
                                    style: PreMedTextTheme().subtext1.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                  TextSpan(
                                    text: 'M',
                                    style: PreMedTextTheme().subtext1.copyWith(color: PreMedColorTheme().primaryColorRed,fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                  TextSpan(
                                    text: 'ed',
                                    style: PreMedTextTheme().subtext1.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
                                  ),
                                  const TextSpan(
                                    text:  " family! We're delighted to have you here. Let the magic begin!",
                                  ),
                                ],
                              ),
                            ),
                            const OptionalOnboardingForm(),
                          ],
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            )));
  }
}
