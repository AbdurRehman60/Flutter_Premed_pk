import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/optional_onboarding.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/utils/data/citites_data.dart';
import 'package:premedpk_mobile_app/utils/data/school_data.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/UI/widgets/school_data_widget.dart';
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
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      auth.phoneNumber = phoneNumber.completeNumber;
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

      if (auth.whatsappNumber.isEmpty) {
        setState(() {
          error = 'WhatsApp number can not be empty.';
          hasErrors = true;
        });
      }
      if (auth.City.isEmpty) {
        setState(() {
          error = 'City can not be empty.';
          hasErrors = true;
        });
      }

      if (auth.School.isEmpty) {
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
            // Add this line to print status code
          },
        );
      }
    }

    return Column(
      children: [
        Container(
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Phone Number',
                    style: PreMedTextTheme().subtext,
                  ),
                ),
                SizedBoxes.verticalTiny,

                PhoneDropdown(
                  onPhoneNumberSelected: onPhoneNumberSelected,
                  hintText: "Enter Your Phone Number",
                ),
                SizedBoxes.verticalMedium,
                PhoneFieldWithCheckbox(
                  onWhatsAppNumberSelected: (whatsappNumber) {
                    auth.whatsappNumber = whatsappNumber;
                  },
                  isPhoneFieldEnabled: auth.whatsappNumber.isEmpty,
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'City',
                    style: PreMedTextTheme().subtext,
                  ),
                ),
                SizedBoxes.verticalTiny,
                // CustomTextField(),
                CityDropdownList(
                  items: cities_data,
                  selectedItem: auth.City,
                  onChanged: onCitySelected,
                ),

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
                  onChanged: onSchoolSelected, // Pass the callback function
                ),

                SizedBoxes.verticalLarge,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Which year are you in?',
                    style: PreMedTextTheme().body,
                  ),
                ),
                SizedBoxes.verticalMicro,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            activeColor: PreMedColorTheme().primaryColorRed,
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
                SizedBoxes.verticalMedium,
                hasErrors
                    ? Text(
                        error,
                        textAlign: TextAlign.center,
                        style: PreMedTextTheme().subtext1.copyWith(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        SizedBoxes.verticalBig,
        CustomButton(
          buttonText: 'Next',
          isIconButton: true,
          icon: Icons.arrow_forward,
          leftIcon: false,
          color: PreMedColorTheme().white,
          textColor: PreMedColorTheme().neutral600,
          onPressed: onNextPressed,
        )
      ],
    );
  }
}

List<String> options = [
  'FSc 1st Year/AS Level',
  'FSc 2nd Year/A2 Level',
  'Have given MDCAT & improving'
];
