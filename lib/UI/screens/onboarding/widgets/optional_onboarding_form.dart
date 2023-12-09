import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/home/homescreen.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/check_box.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:provider/provider.dart';

class OptionalOnboardingForm extends StatefulWidget {
  const OptionalOnboardingForm({super.key});

  @override
  State<OptionalOnboardingForm> createState() => _OptionalOnboardingFormState();
}

class _OptionalOnboardingFormState extends State<OptionalOnboardingForm> {
  bool mdcatChecked = false;
  bool akuChecked = false;
  bool numsChecked = false;
  TextEditingController parentNameController = TextEditingController();

  String error = "";
  bool hasErrors = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void updateIntendFor() {
      List<String> intendFor = [];
      if (mdcatChecked) intendFor.add('MDCAT');
      if (akuChecked) intendFor.add('AKU');
      if (numsChecked) intendFor.add('NUMS');

      auth.intendFor = intendFor;
    }

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      if (phoneNumber.number.isEmpty) {
        auth.parentContactNumber = '';
      } else {
        auth.parentContactNumber = phoneNumber.completeNumber;
      }
    }

    bool validateInput() {
      error = '';
      hasErrors = false;

      if ((auth.parentFullName.isEmpty &&
              auth.parentContactNumber.isNotEmpty) ||
          (auth.parentFullName.isNotEmpty &&
              auth.parentContactNumber.isEmpty)) {
        setState(() {
          error = "Parent's details can not be empty.";
          hasErrors = true;
        });
      } else {
        setState(() {
          hasErrors = false;
        });
      }

      return !hasErrors;
    }

    void onNextPressed() {
      auth.parentFullName = parentNameController.text;
      if (validateInput()) {
        final Future<Map<String, dynamic>> response = auth.optionalOnboarding();

        response.then(
          (response) {
            if (response['status']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainNavigationScreen(),
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
                SizedBoxes.verticalMedium,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Parents Name:',
                    style: PreMedTextTheme().subtext,
                  ),
                ),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  controller: parentNameController,
                  hintText: 'Enter Parents name',
                ),
                SizedBoxes.verticalMedium,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Parents Phone Number',
                    style: PreMedTextTheme().subtext,
                  ),
                ),
                SizedBoxes.verticalMedium,
                PhoneDropdown(
                  onPhoneNumberSelected: onPhoneNumberSelected,
                  hintText: "Enter your parent's phone number",
                ),
                SizedBoxes.verticalLarge,
                Text(
                  'What did you intend to use PreMed.PK for ?',
                  style: PreMedTextTheme().subtext,
                ),
                SizedBoxes.verticalMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: CustomCheckBox(
                        label: "MDCAT",
                        initialValue: mdcatChecked,
                        onChanged: (value) {
                          setState(() {
                            mdcatChecked = value;
                            updateIntendFor();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: CustomCheckBox(
                        label: "AKU",
                        initialValue: akuChecked,
                        onChanged: (value) {
                          setState(() {
                            akuChecked = value;
                            updateIntendFor();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: CustomCheckBox(
                        label: "NUMS",
                        initialValue: numsChecked,
                        onChanged: (value) {
                          setState(() {
                            numsChecked = value;
                            updateIntendFor();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBoxes.verticalGargangua,
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Have you joined any academy?',
                    style: PreMedTextTheme().subtext,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: options.map((option) {
                    return Row(
                      children: [
                        Radio(
                          value: option,
                          groupValue: auth.academyJoined,
                          onChanged: (value) {
                            auth.academyJoined = value!;
                          },
                          activeColor: PreMedColorTheme().primaryColorRed,
                          visualDensity: VisualDensity.compact,
                        ),
                        Text(
                          option,
                          style: PreMedTextTheme().subtext,
                        ),
                      ],
                    );
                  }).toList(),
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
        SizedBoxes.verticalGargangua,
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: CustomButton(
                buttonText: '',
                isOutlined: true,
                isIconButton: true,
                icon: Icons.arrow_back,
                leftIcon: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequiredOnboarding(),
                    ),
                  );
                },
              ),
            ),
            SizedBoxes.horizontalMedium,
            Expanded(
              flex: 7,
              child: CustomButton(
                buttonText: "Let's Start Learning!",
                isIconButton: true,
                color: PreMedColorTheme().white,
                textColor: PreMedColorTheme().neutral600,
                icon: Icons.arrow_forward,
                leftIcon: false,
                onPressed: onNextPressed,
              ),
            )
          ],
        ),
      ],
    );
  }
}

List<String> options = [
  'Yes',
  'No',
];
