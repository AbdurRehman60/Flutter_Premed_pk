import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:premedpk_mobile_app/utils/Data/school_data.dart';
import 'package:provider/provider.dart';

import '../../../../repository/auth_provider.dart';

class RequiredOnboardingForm extends StatefulWidget {
  const RequiredOnboardingForm({super.key});

  @override
  State<RequiredOnboardingForm> createState() => _RequiredOnboardingFormState();
}

class _RequiredOnboardingFormState extends State<RequiredOnboardingForm> {
  @override
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      auth.phoneNumber = phoneNumber.completeNumber;
    }

    void handleOptionSelected(String selectedOption) {
      print("Selected option: $selectedOption");
    }

    void onCitySelected(String? selectedCity) {
      auth.setCity(selectedCity!);
    }

    void onSchoolSelected(String selectedSchool) {
      auth.setSchool(selectedSchool);
    }

    void onNextPressed() {
      print("phonenumber:${auth.phoneNumber}");
      print("city:${auth.City}");
      print("School:${auth.School}");
      print("WhichYear: ${auth.intendedYear}");
      print("whatsappNumber: ${auth.whatsappNumber}");
    }

    return Form(
      key: _formKey,
      child: Column(
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
                  PhoneDropdown(
                    onPhoneNumberSelected: onPhoneNumberSelected,
                  ),
                  SizedBoxes.verticalMedium,
                  PhoneFieldWithCheckbox(
                    onWhatsAppNumberSelected: (whatsappNumber) {
                      auth.whatsappNumber = whatsappNumber;
                    },
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
                    selectedItem: cities_data[0],
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
                    children: options.map((option) {
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
                    }).toList(),
                  )
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
      ),
    );
  }
}

List<String> options = [
  'FSc 1st Year/AS Level',
  'FSc 2nd Year/A2 Level',
  'Have given MDCAT & improving'
];
