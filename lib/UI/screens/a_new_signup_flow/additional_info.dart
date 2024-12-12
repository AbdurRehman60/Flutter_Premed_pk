import 'package:geocoding/geocoding.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/a_new_onboarding/choose_features.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/Data/citites_data.dart';
import '../../../utils/Data/school_data.dart';
import '../../Widgets/cities_data_widget.dart';
import '../../Widgets/global_widgets/custom_button.dart';
import '../../Widgets/global_widgets/error_dialogue.dart';
import '../../Widgets/phone_dropdown.dart';
import '../../Widgets/school_data_widget.dart';
import '../Onboarding/widgets/check_box.dart';
import '../marketplace/widgets/coupon_code.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({super.key});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  final _formKey = GlobalKey<FormState>();
  String city = '';
  String institution = '';
  String educationSystem = '';
  String year = '';
  String knownVia = '';
  String parentContactNumber = '';
  String phoneNumber = '';
  bool hasErrors = false;
  String error = "";
  bool isAvailableOnWhatsApp = false;
  String province = '';
  String referral = '';

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

  final List<String> educationOptions = [
    'Cambridge O/A levels',
    'FSc Intermediate',
    'Have given MDCAT & improving',
    'Other'
  ];

  Future<void> identifyProvinceFromCity(String selectedCity) async {
    try {
      List<Location> locations = await locationFromAddress(selectedCity);
      if (locations.isEmpty) {
        locations = await locationFromAddress("$selectedCity, Pakistan");
      }
      if (locations.isNotEmpty) {
        Location cityLocation = locations.first;
        List<Placemark> placemarks = await placemarkFromCoordinates(
          cityLocation.latitude,
          cityLocation.longitude,
        );

        if (placemarks.isNotEmpty) {
          setState(() {
            province = placemarks[0].administrativeArea ?? '';
          });
        } else {
          setState(() {
            hasErrors = true;
            error = "Could not identify province.";
          });
        }
      } else {
        setState(() {
          hasErrors = true;
          error = "City not found.";
        });
      }
    } catch (e) {
      setState(() {
        hasErrors = true;
        error = "Error identifying province: ${e.toString()}";
      });
    }
  }

  void onParentPhoneNumberSelected(PhoneNumber phoneNumber) {
    setState(() {
      parentContactNumber = phoneNumber.completeNumber;
    });
  }

  void onPhoneNumberSelected(PhoneNumber phoneNumber) {
    setState(() {
      this.phoneNumber = phoneNumber.completeNumber;
      parentContactNumber = phoneNumber.completeNumber;
    });
  }

  void onSubmitAdditionalInfo() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      await identifyProvinceFromCity(city);

      if (province.isEmpty) {
        setState(() {
          hasErrors = true;
          error = "Province identification failed. Please check your city.";
        });
        return;
      }

      final AuthProvider auth =
      Provider.of<AuthProvider>(context, listen: false);
      final UserProvider user =
      Provider.of<UserProvider>(context, listen: false);

      final Future<Map<String, dynamic>> onboardingResponse = auth
          .requiredOnboarding(
        username: user.user!.userName,
        lastOnboardingPage:
        "/auth/onboarding/entrance-exam/pre-medical/additional-info/features",
        selectedExams: [],
        selectedFeatures: [],
        city: city,
        educationSystem: educationSystem,
        year: year,
        parentContactNumber: parentContactNumber,
        approach: knownVia,
        phoneNumber: phoneNumber,
        institution: institution,
        isAvailableOnWhatsApp: isAvailableOnWhatsApp,
        province: province,
        referral: referral,
      );

      onboardingResponse.then((response) {
        if (response['status']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ChooseFeatures(),
            ),
          );
        } else {
          showError(context, response);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBoxes.verticalLarge,
                        RichText(
                          text: TextSpan(
                            style: PreMedTextTheme().heading1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 34,
                              color: PreMedColorTheme().primaryColorRed,
                            ),
                            children: [
                              const TextSpan(text: 'Additional '),
                              TextSpan(
                                text: 'Info',
                                style: PreMedTextTheme().heading1.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 34,
                                    color: PreMedColorTheme().black),
                              ),
                              const TextSpan(text: '.')
                            ],
                          ),
                        ),
                        SizedBoxes.verticalTiny,
                        Text(
                          'Let us know more about you!',
                          style: PreMedTextTheme().heading1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              color: PreMedColorTheme().primaryColorRed),
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
                        CustomCheckBox(
                          label: 'Available on WhatsApp?',
                          initialValue: isAvailableOnWhatsApp,
                          onChanged: (checked) {
                            setState(() {
                              isAvailableOnWhatsApp = checked;
                            });
                          },
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
                            "Parent's Contact Information",
                            style: PreMedTextTheme().subtext1,
                          ),
                        ),
                        SizedBoxes.verticalTiny,
                        PhoneDropdown(
                          onPhoneNumberSelected: onParentPhoneNumberSelected,
                          hintText: "",
                          initialValue: parentContactNumber,
                        ),
                        SizedBoxes.verticalBig,
                        CityDropdownList(
                          items: cities,
                          selectedItem: city,
                          onChanged: (selectedCity) {
                            setState(() {
                              city = selectedCity!;
                            });
                          },
                        ),
                        SizedBoxes.verticalMedium,
                        SchoolDropdownList(
                          items: schoolsdata,
                          selectedItem: institution,
                          onChanged: (selectedSchool) {
                            setState(() {
                              institution = selectedSchool;
                            });
                          },
                        ),
                        SizedBoxes.verticalBig,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Education System',
                            style: PreMedTextTheme().subtext1,
                          ),
                        ),
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
                              items: educationOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (selectedEducationSystem) {
                                setState(() {
                                  educationSystem =
                                      selectedEducationSystem ?? '';
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                hintText: "Select your education system",
                                hintStyle: PreMedTextTheme().subtext.copyWith(
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
                            style: PreMedTextTheme().subtext1,
                          ),
                        ),
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
                              onChanged: (selectedYear) {
                                setState(() {
                                  year = selectedYear ?? '';
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                hintText: "Select your year",
                                hintStyle: PreMedTextTheme().subtext.copyWith(
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
                            style: PreMedTextTheme().subtext1,
                          ),
                        ),
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
                              onChanged: (selectedOption) {
                                setState(() {
                                  knownVia = selectedOption ?? '';
                                  if (knownVia == 'Associate') {
                                    referral = '';
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                hintText: "How did you get to know us?",
                                hintStyle: PreMedTextTheme().subtext.copyWith(
                                    color: PreMedColorTheme().black),
                              ),
                            ),
                          ),
                        ),
                        SizedBoxes.verticalBig,
                        if (knownVia == 'Associate') const CouponCodeTF(),
                        CustomButton(
                          buttonText: 'Submit',
                          onPressed: onSubmitAdditionalInfo,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
