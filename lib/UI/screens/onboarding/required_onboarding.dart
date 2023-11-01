import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/required_onboarding_form.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/ui/screens/onboarding/widgets/curve_painter.dart';

class RequiredOnboarding extends StatelessWidget {
  const RequiredOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: PreMedColorTheme().primaryGradient,
              ),
            ),
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
                    children: [
                      SizedBoxes.verticalBig,
                      Text(
                        'Welcome Aboard',
                        style: PreMedTextTheme().heading2.copyWith(
                              color: PreMedColorTheme().primaryColorRed,
                            ),
                      ),
                      SizedBoxes.verticalTiny,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Just One More Step to Begin Your Journey in Medicine.',
                            style: PreMedTextTheme().subtext.copyWith(
                                  color: PreMedColorTheme().neutral500,
                                  height: 1.4,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBoxes.verticalExtraGargangua,
                      const RequiredOnboardingForm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//test