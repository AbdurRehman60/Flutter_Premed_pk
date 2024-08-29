import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/a_new_onboarding/choose_school.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../utils/Data/citites_data.dart';
import '../../../utils/Data/school_data.dart';
import '../../Widgets/cities_data_widget.dart';
import '../../Widgets/global_widgets/custom_button.dart';
import '../../Widgets/global_widgets/custom_textfield.dart';
import '../../Widgets/global_widgets/error_dialogue.dart';
import '../../Widgets/phone_dropdown.dart';
import '../../Widgets/school_data_widget.dart';
import '../onboarding/required_onboarding.dart';
import '../onboarding/widgets/optional_checkbox.dart';

class SignUpFlow extends StatefulWidget {
  const SignUpFlow({super.key});

  @override
  State<SignUpFlow> createState() => _SignUpFlowState();
}

class _SignUpFlowState extends State<SignUpFlow> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController confirmEmailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  bool hasErrors = false;
  String error = "";
  String city = '';
  String institution = '';
  String educationSystem = '';
  String year = '';
  String knownVia = '';
  String parentContactNumber = '';
  String phoneNumber = '';

  final List<String> educationSystems = [
    'Intermediate/Fsc',
    'Cambridge O/A levels',
    'Other'
  ];

  final List<String> years = [
    '1st year FSc/AS levels',
    '2nd year FSc/AS levels',
    'MDCAT improver',
    'Other'
  ];

  final List<String> knownViaOptions = [
    'Facebook',
    'WhatsApp',
    'Instagram',
    'Associate'
  ];

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      setState(() {
        this.phoneNumber = phoneNumber.completeNumber;
      });
    }

    void onEducationSystemSelected(String? selectedSystem) {
      setState(() {
        educationSystem = selectedSystem ?? '';
      });
    }

    void onCitySelected(String? selectedCity) {
      setState(() {
        city = selectedCity ?? '';
      });
    }

    void onSchoolSelected(String? selectedSchool) {
      setState(() {
        institution = selectedSchool ?? '';
      });
    }

    void onSignupPressed() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> signupResponse = auth.signup(
          emailController.text,
          passwordController.text,
          fullNameController.text,
          appUser: true
        );

        signupResponse.then((response) {
          if (response['status']) {
            final Future<Map<String, dynamic>> onboardingResponse =
            auth.requiredOnboarding(
              username: emailController.text,
              lastOnboardingPage: '',
              selectedExams: [],
              selectedFeatures: [],
              city: city,
              educationSystem: educationSystem,
              year: year,
              parentContactNumber: parentContactNumber,
              approach: knownVia,
              phoneNumber: phoneNumber,
              institution: institution,
            );

            onboardingResponse.then((onboardingResponse) {
              if (onboardingResponse['status']) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChooseSchool(
                      password: passwordController.text,
                      city: city,
                      institution: institution,
                      phoneNumber: phoneNumber,
                      educationSystem: educationSystem,
                    ),
                  ),
                );
              } else {
                showError(context, onboardingResponse);
              }
            });
          } else {
            showError(context, response);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBoxes.verticalLarge,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBoxes.verticalExtraGargangua,
                              Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: PreMedTextTheme().heading1.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 34,
                                    color: PreMedColorTheme().primaryColorRed),
                              ),
                              SizedBoxes.verticalTiny,
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: PreMedTextTheme().subtext.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: PreMedColorTheme().black),
                                  children: [
                                    const TextSpan(
                                      text: 'A warm welcome to the ',
                                    ),
                                    TextSpan(
                                      text: 'Pre',
                                      style: PreMedTextTheme().subtext1,
                                    ),
                                    TextSpan(
                                      text: 'M',
                                      style: PreMedTextTheme()
                                          .subtext1
                                          .copyWith(
                                          color: PreMedColorTheme()
                                              .primaryColorRed),
                                    ),
                                    TextSpan(
                                      text: 'ed',
                                      style: PreMedTextTheme().subtext1,
                                    ),
                                    const TextSpan(
                                      text:
                                      ' family! We\'re delighted to have you here. Let the magic begin!',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBoxes.verticalGargangua,
                              CustomTextField(
                                controller: fullNameController,
                                prefixIcon:
                                const Icon(Icons.person_outline_rounded),
                                hintText: 'Enter your full name',
                                labelText: 'Full Name',
                                validator: validateFullname,
                              ),
                              SizedBoxes.verticalBig,
                              CustomTextField(
                                controller: emailController,
                                prefixIcon: const Icon(Icons.mail_outline),
                                hintText: 'Enter your email',
                                labelText: 'Email',
                                validator: (value) => validateEmail(value),
                              ),
                              SizedBoxes.verticalBig,
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
                                initialValue: phoneNumber,
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
                                ),
                              SizedBoxes.verticalBig,
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
                                selectedItem: city,
                                onChanged: onCitySelected,
                              ),
                              SizedBoxes.verticalMedium,
                              SchoolDropdownList(
                                items: schoolsdata,
                                selectedItem: institution,
                                onChanged: onSchoolSelected,
                              ),
                              SizedBoxes.verticalMedium,
                              Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: PreMedColorTheme().white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: educationSystem.isEmpty
                                        ? null
                                        : educationSystem,
                                    items: educationSystems.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: onEducationSystemSelected,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                      hintText: "Education System",
                                      hintStyle: PreMedTextTheme()
                                          .subtext
                                          .copyWith(
                                          color: PreMedColorTheme().black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBoxes.verticalBig,
                              CustomTextField(
                                controller: passwordController,
                                prefixIcon: const Icon(Icons.lock_outline),
                                hintText: 'Enter your password',
                                labelText: 'Password',
                                obscureText: true,
                                validator: validatePassword,
                              ),
                              SizedBoxes.verticalBig,
                              CustomTextField(
                                controller: confirmPasswordController,
                                prefixIcon: const Icon(Icons.lock_outline),
                                hintText: 'Re-enter your password',
                                labelText: 'Confirm Password',
                                obscureText: true,
                                validator: validatePassword,
                              ),
                              SizedBoxes.verticalBig,
                              CustomButton(
                                buttonText: 'Sign Up',
                                onPressed: () async {
                                  onSignupPressed();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateFullname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    } else if (value.length < 3) {
      return 'Incorrect name length';
    } else if (value.contains(RegExp(r'[0-9]'))) {
      return 'Full name should not contain numbers';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!value.contains('@') || !value.contains('com')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateConfirmEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Email is required';
    } else if (!value.contains('@') || !value.contains('com')) {
      return 'Invalid email format';
    } else if (emailController.text != value) {
      return "Emails don't match";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }


}
