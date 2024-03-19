import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/optional_onboarding.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/hubspot_help.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/UI/widgets/school_data_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:premedpk_mobile_app/utils/data/school_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'dart:math' as math;
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';

class RequiredOnboardingForm extends StatefulWidget {
  const RequiredOnboardingForm({super.key});

  @override
  State<RequiredOnboardingForm> createState() => _RequiredOnboardingFormState();
}

class _RequiredOnboardingFormState extends State<RequiredOnboardingForm> {
  String error = "";
  bool hasErrors = false;

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      auth.phoneNumber = phoneNumber.completeNumber;
      auth.country = phoneNumber.countryCode;
    }

    void onCitySelected(String? selectedCity) {
      auth.setCity(selectedCity!);
    }

    void onSchoolSelected(String selectedSchool) {
      auth.setSchool(selectedSchool);
    }

    bool validateInput() {
      error = '';
      hasErrors = false;

      if (auth.phoneNumber.isEmpty) {
        setState(() {
          error = 'Phone number can not be empty.';
          hasErrors = true;
        });
      }

      // if (auth.city.isEmpty) {
      //   setState(() {
      //     error = 'City can not be empty.';
      //     hasErrors = true;
      //   });
      // }

      if (auth.school.isEmpty) {
        setState(() {
          error = 'School can not be empty.';
          hasErrors = true;
        });
      }
      return !hasErrors;
    }

    void onNextPressed() {
      if (validateInput()) {
        final Future<Map<String, dynamic>> response = auth.requiredOnboarding();

        response.then(
          (response) {
            if (response['status']) {
              // User user = response['user'];

              // Provider.of<UserProvider>(context, listen: false).setUser(user);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const OptionalOnboarding(),
                ),
              );
            } else {
              showError(context, response);
            }
          },
        );
      }
    }

    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Educational Information',
                    textAlign: TextAlign.start,
                    style: PreMedTextTheme().subtext1,
                  ),
                ),
                SizedBoxes.verticalLarge,
                SchoolDropdownList(
                  items: schoolsdata,
                  selectedItem: auth.school,
                  onChanged: onSchoolSelected, // Pass the callback function
                ),
                SizedBoxes.verticalLarge,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Contact Information',
                    style: PreMedTextTheme().subtext1,
                  ),
                ),
                SizedBoxes.verticalTiny,
                PhoneDropdown(
                  onPhoneNumberSelected: onPhoneNumberSelected,
                  hintText: "",
                  initialValue: auth.phoneNumber,
                ),
                SizedBoxes.verticalMedium,
                PhoneFieldWithCheckbox(
                  onWhatsAppNumberSelected: (whatsappNumber) {
                    auth.whatsappNumber = whatsappNumber;
                  },
                  isPhoneFieldEnabled: auth.whatsappNumber.isEmpty ||
                      auth.whatsappNumber == auth.phoneNumber,
                  initialValue: auth.whatsappNumber,
                ),
                SizedBoxes.verticalLarge,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Parent\'s Information',
                    style: PreMedTextTheme().subtext1,
                  ),
                ),
                SizedBoxes.verticalTiny,
                CustomTextField(
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  labelText: 'Parent/Guardian\'s Name',
                ),
                SizedBoxes.verticalTiny,
                CustomTextField(
                  prefixIcon: Transform.rotate(
                      angle: math.pi / 2, child: Icon(Icons.phone_enabled_outlined)),
                  labelText: 'Parent/Guardian\'s Name',
                ),
                if (hasErrors)
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme().subtext1.copyWith(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
        ),
        SizedBoxes.verticalBig,
        CustomButton(
          buttonText: 'Create Account',
          color: PreMedColorTheme().primaryColorRed,
          textColor: PreMedColorTheme().white,
          onPressed: onNextPressed,
        ),
        SizedBoxes.verticalBig,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: PreMedTextTheme().body.copyWith(
              color: PreMedColorTheme().neutral500,
            ),
            children: [
              TextSpan(
                text: "By signing in, you agree to our ",
                style: PreMedTextTheme().body.copyWith(
                  color: PreMedColorTheme().neutral500,
                ),
              ),
              TextSpan(
                text: "Privacy Policy",
                style: PreMedTextTheme().body1.copyWith(
                  color: PreMedColorTheme().neutral500,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy() ));
                  },
              ),
              TextSpan(
                text: " and ",
                style: PreMedTextTheme().body.copyWith(
                  color: PreMedColorTheme().neutral500,
                ),
              ),
              TextSpan(
                text: "Terms of Use",
                style: PreMedTextTheme().body1.copyWith(
                    color: PreMedColorTheme().neutral500
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TermsCondition() ));
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

