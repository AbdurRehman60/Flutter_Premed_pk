import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/optional_checkbox.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/Data/citites_data.dart';
import '../../../utils/Data/school_data.dart';
import '../../Widgets/cities_data_widget.dart';
import '../../Widgets/phone_dropdown.dart';
import '../../Widgets/school_data_widget.dart';
import '../navigation_screen/main_navigation_screen.dart';

class OptionalOnboarding extends StatefulWidget {
  const OptionalOnboarding({super.key});

  @override
  State<OptionalOnboarding> createState() => _OptionalOnboardingState();
}

class _OptionalOnboardingState extends State<OptionalOnboarding> {
  final _formKey = GlobalKey<FormState>();
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
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final String? lastob = userProvider.user?.info.lastOnboardingPage;
    final String? username = userProvider.user?.userName;
    final List<String> features =
        (userProvider.user?.info.features ?? []).cast<String>();
    final List<String> exams =
        (userProvider.user?.info.exam ?? []).cast<String>();

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      setState(() {
        this.phoneNumber = phoneNumber.completeNumber;
      });
    }

    void onParentPhoneNumberSelected(PhoneNumber phoneNumber) {
      setState(() {
        parentContactNumber = phoneNumber.completeNumber;
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

    void onEducationSystemSelected(String? selectedSystem) {
      setState(() {
        educationSystem = selectedSystem ?? '';
      });
    }

    void onYearSelected(String? selectedYear) {
      setState(() {
        year = selectedYear ?? '';
      });
    }

    void onKnownViaSelected(String? selectedOption) {
      setState(() {
        knownVia = selectedOption ?? '';
      });
    }

    bool validateInput() {
      error = '';
      hasErrors = false;

      if (phoneNumber.isEmpty ||
          city.isEmpty ||
          institution.isEmpty ||
          educationSystem.isEmpty ||
          year.isEmpty ||
          knownVia.isEmpty) {
        setState(() {
          error = "All fields are required.";
          hasErrors = true;
        });
        return false;
      } else {
        setState(() {
          hasErrors = false;
        });
        return true;
      }
    }

    void showErrorDialog(String errorMessage) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

    Future<void> submitOnboardingData() async {
      if (!validateInput()) {
        showErrorDialog(error);
        return;
      }

      try {
        final result = await auth.requiredOnboarding(
          username: username!,
          lastOnboardingPage: '$lastob/additional-info',
          selectedExams: exams,
          selectedFeatures: features,
          city: city,
          educationSystem: educationSystem,
          year: year,
          parentContactNumber: parentContactNumber,
          approach: knownVia,
          phoneNumber: phoneNumber,
          institution: institution,
        );

        if (result['status']) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(),
            ),
            (route) => false,
          );
        } else {
          setState(() {
            error = 'Failed to submit data. Please try again.';
            hasErrors = true;
          });
          showErrorDialog(error);
        }
      } catch (e) {
        setState(() {
          error = 'An error occurred. Please try again.';
          hasErrors = true;
        });
        showErrorDialog(error);
      }
    }

    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBoxes.verticalMedium,
                              RichText(
                                text: TextSpan(
                                  style: PreMedTextTheme().subtext.copyWith(
                                        color: PreMedColorTheme().black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: 'Let us know more about you',
                                      style: PreMedTextTheme().body.copyWith(
                                            color: PreMedColorTheme()
                                                .primaryColorRed,
                                            fontSize: 35,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const TextSpan(text: '!'),
                                  ],
                                ),
                              ),
                              SizedBoxes.verticalMedium,
                              RichText(
                                text: TextSpan(
                                  style: PreMedTextTheme().subtext.copyWith(
                                        color: PreMedColorTheme().black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  children: [
                                    const TextSpan(
                                      text: 'Additional ',
                                    ),
                                    TextSpan(
                                      text: 'Info',
                                      style: PreMedTextTheme().body.copyWith(
                                            color: PreMedColorTheme()
                                                .primaryColorRed,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
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
                                isPhoneFieldEnabled:
                                    auth.whatsappNumber.isEmpty ||
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
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Parent's Contact",
                                  style: PreMedTextTheme().subtext1,
                                ),
                              ),
                              SizedBoxes.verticalTiny,
                              PhoneDropdown(
                                onPhoneNumberSelected:
                                    onParentPhoneNumberSelected,
                                hintText: "",
                                initialValue: parentContactNumber,
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
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'What Year Are You In?',
                                  textAlign: TextAlign.start,
                                  style: PreMedTextTheme().subtext1,
                                ),
                              ),
                              SizedBoxes.verticalTiny,
                              Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: PreMedColorTheme().white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: year.isEmpty ? null : year,
                                    items: years.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: onYearSelected,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      hintText: "Which year are you in?",
                                      hintStyle: PreMedTextTheme()
                                          .subtext
                                          .copyWith(
                                              color: PreMedColorTheme().black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBoxes.verticalBig,
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'How Did You Get to Know About Us?',
                                  textAlign: TextAlign.start,
                                  style: PreMedTextTheme().subtext1,
                                ),
                              ),
                              SizedBoxes.verticalTiny,
                              Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: PreMedColorTheme().white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    value: knownVia.isEmpty ? null : knownVia,
                                    items: knownViaOptions.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: onKnownViaSelected,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 10),
                                      hintText:
                                          "How did you get to know about us?",
                                      hintStyle: PreMedTextTheme()
                                          .subtext
                                          .copyWith(
                                              color: PreMedColorTheme().black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PreMedColorTheme().primaryColorRed200,
                          width: 6,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().neutral60,
                        radius: 20,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 28,
                          color: PreMedColorTheme().primaryColorRed,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      submitOnboardingData();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PreMedColorTheme().bordercolor,
                          width: 6,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().primaryColorRed,
                        radius: 28,
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
