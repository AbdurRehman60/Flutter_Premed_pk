import 'package:flutter/gestures.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/UI/widgets/school_data_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:premedpk_mobile_app/utils/data/school_data.dart';
import 'package:provider/provider.dart';

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

      return !hasErrors;
    }

    void onNextPressed() {
      if (validateInput()) {
        final Future<Map<String, dynamic>> response = auth.requiredOnboarding();

        response.then(
              (response) {
            if (response['status']) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainNavigationScreen(),
                ),
                  (route) => false,
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
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16,),
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
              CityDropdownList(
                  items: cities,
                  selectedItem: auth.city,
                  onChanged: onCitySelected),

              SizedBoxes.verticalBig,
              SchoolDropdownList(
                items: schoolsdata,
                selectedItem: auth.school,
                onChanged: onSchoolSelected,
              ),
              SizedBoxes.verticalBig,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: options.map(
                      (option) {
                    return Row(
                      children: [
                        Radio(
                          value: option,
                          groupValue: auth.intendedYear,
                          onChanged: (value) {
                            auth.intendedYear = value!;
                          },
                          visualDensity: VisualDensity.compact,
                          activeColor: PreMedColorTheme().tickcolor,
                        ),
                        Flexible(
                          child: Text(
                            option,
                            style: PreMedTextTheme().subtext,
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),

              SizedBoxes.verticalBig,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Contact Information',
                  style: PreMedTextTheme().subtext1,
                ),
              ),
              SizedBoxes.verticalLarge,
              PhoneDropdown(
                onPhoneNumberSelected: onPhoneNumberSelected,
                hintText: "",
                initialValue: auth.phoneNumber,
              ),
              SizedBoxes.verticalBig,
              PhoneFieldWithCheckbox(
                onWhatsAppNumberSelected: (whatsappNumber) {
                  auth.whatsappNumber = whatsappNumber;
                },
                isPhoneFieldEnabled: auth.whatsappNumber.isEmpty ||
                    auth.whatsappNumber == auth.phoneNumber,
                initialValue: auth.whatsappNumber,
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
            ],
          ),
        ),
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
                    fontWeight: FontWeight.w400, fontSize: 11
                ),
              ),
              TextSpan(
                text: "Privacy Policy",
                style: PreMedTextTheme().body1.copyWith(
                    color: PreMedColorTheme().neutral500,
                    fontWeight: FontWeight.w700, fontSize: 11
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy()));
                  },
              ),
              TextSpan(
                text: " and ",
                style: PreMedTextTheme().body.copyWith(
                    color: PreMedColorTheme().neutral500,
                    fontWeight: FontWeight.w400, fontSize: 11
                ),
              ),
              TextSpan(
                text: "Terms of Use",
                style: PreMedTextTheme()
                    .body1
                    .copyWith(color: PreMedColorTheme().neutral500,
                    fontWeight: FontWeight.w700, fontSize: 11),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsCondition()));
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<String> options = [
  'FSc 1st Year/AS Level',
  'FSc 2nd Year/A2 Level',
  'Have given MDCAT & improving'
];
