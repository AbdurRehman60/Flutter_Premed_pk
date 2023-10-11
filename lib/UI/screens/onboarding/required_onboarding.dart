import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/ui/screens/onboarding/widgets/curve_painter.dart';
import 'package:premedpk_mobile_app/ui/screens/onboarding/widgets/radio_button.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:premedpk_mobile_app/utils/Data/country_code_data.dart';
import 'package:premedpk_mobile_app/utils/Data/school_data.dart';

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
                      const saadOnbaording(),
                      SizedBoxes.verticalBig,
                      CustomButton(
                        buttonText: 'Next',
                        isIconButton: true,
                        icon: Icons.arrow_forward,
                        leftIcon: false,
                        color: PreMedColorTheme().white,
                        textColor: PreMedColorTheme().neutral600,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OptionalOnboarding(),
                            ),
                          );
                        },
                      )
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

class saadOnbaording extends StatelessWidget {
  const saadOnbaording({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreMedColorTheme().white,
        border: Border.all(
          color: PreMedColorTheme().neutral300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            PhoneDropdown(),
            SizedBoxes.verticalLarge,
            // OptionalCheckBox(),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'City',
                style: PreMedTextTheme().subtext,
              ),
            ),
            SizedBoxes.verticalTiny,
            CityDropdownList(
                items: cities_data,
                selectedItem: cities_data[0],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    print(newValue);
                  }
                }),
            SizedBoxes.verticalLarge,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'School Name',
                textAlign: TextAlign.start,
                style: PreMedTextTheme().subtext,
              ),
            ),
            SizedBoxes.verticalLarge,
            SchoolDropdownList(
                items: schools_data,
                selectedItem: schools_data[0],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    print(newValue);
                  }
                }),
            SizedBoxes.verticalLarge,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Which year are you in?',
                style: PreMedTextTheme().subtext,
              ),
            ),
            SizedBoxes.verticalLarge,
            const RadioButtons(),
          ],
        ),
      ),
    );
  }
}

//test