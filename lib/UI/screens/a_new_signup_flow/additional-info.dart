import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/a_new_onboarding/choose_school.dart';
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
import '../onboarding/widgets/optional_checkbox.dart';

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

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    final UserProvider user = Provider.of<UserProvider>(context);

    void onSubmitAdditionalInfo() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> onboardingResponse = auth.requiredOnboarding(
          username: user.user!.userName,
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

        onboardingResponse.then((response) {
          if (response['status']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseSchool(
                  city: city,
                  institution: institution,
                  phoneNumber: phoneNumber,
                ),
              ),
            );
          } else {
            showError(context, response);
          }
        });
      }
    }
    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      setState(() {
        this.phoneNumber = phoneNumber.completeNumber;
      });
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBoxes.verticalExtraGargangua,
                              RichText(
                                text: TextSpan(
                                    style: PreMedTextTheme().heading1.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 34,
                                        color: PreMedColorTheme().primaryColorRed),
                                    children: [
                                      const TextSpan(
                                          text: 'Additional '
                                      ),
                                      TextSpan(
                                        text: 'Info',
                                        style: PreMedTextTheme().heading1.copyWith(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 34,
                                            color: PreMedColorTheme().black),
                                      ),
                                      const TextSpan(
                                          text: '.'
                                      )
                                    ]
                                ),
                              ),
                              SizedBoxes.verticalTiny,
                              Text(
                                'Let us know more about you!',
                                textAlign: TextAlign.left,
                                style: PreMedTextTheme().heading1.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                    color: PreMedColorTheme().primaryColorRed),
                              ),
                              SizedBoxes.verticalGargangua,
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
                                    institution = selectedSchool!;
                                  });
                                },
                              ),
                              SizedBoxes.verticalBig,
                              CustomButton(
                                buttonText: 'Submit',
                                onPressed: () {
                                  onSubmitAdditionalInfo();
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
}

