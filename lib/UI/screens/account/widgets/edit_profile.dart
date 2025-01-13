import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/Widgets/school_data_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/delete_account.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/school_data.dart';
import 'package:provider/provider.dart';
import '../../../../utils/Data/citites_data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserProvider userProvider = UserProvider();
  final AuthProvider auth = AuthProvider();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String initialPhoneNumber = '';
  String city = '';
  String university = '';

  @override
  void initState() {
    fullNameController.text = userProvider.user!.fullName;
    emailController.text = userProvider.user!.userName;
    initialPhoneNumber = userProvider.user!.phoneNumber;
    city = userProvider.user!.city;
    university = userProvider.user!.school;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    Future<void> onEditDetailsPressed() async {
      final String phoneNumber = userProvider.phoneNumber;
      final List<String> selectedExams =
      userProvider.user!.info.exam
          .map((e) => e.toString().trim())
          .toList();

      final List<String> selectedFeatures =
      userProvider.user!.info.features
          .map((e) => e.toString().trim())
          .toList();


      final String cityy = city;
      final String instituiton = university;



      final form = formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> response =
            auth.requiredOnboarding(
              selectedExams: selectedExams,
              selectedFeatures: selectedFeatures,
              phoneNumber: phoneNumber,
              city: cityy,
              institution: instituiton,
               );
        response.then(
          (response) {
            if (response['status']) {
              auth.getLoggedInUser();
              showSnackbar(
                context,
                "User Details Updated",
                SnackbarType.SUCCESS,
              );
            } else {
              showError(context, response);
            }
          },
        );
      }
    }

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      userProvider.phoneNumber = phoneNumber.completeNumber;
    }

    void onCitySelected(String? selectedCity) {
      if (selectedCity != null) {
        setState(() {
          city = selectedCity;
        });
      }
    }

    void onSchoolSelected(String selectedSchool) {
      setState(() {
        university = selectedSchool;
      });
    }

    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().background,
        leading: const PopButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Account',
              style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black, fontWeight: FontWeight.bold),
            ),
            SizedBoxes.vertical2Px,
            Text('SETTINGS',
                style: PreMedTextTheme().subtext.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: PreMedColorTheme().black,
                    ))
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: fullNameController,
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      hintText: 'Enter your full name',
                      labelText: 'Full Name',
                      validator: validateFullname,
                      enabled: false,
                    ),
                    SizedBoxes.verticalMedium,
                    CustomTextField(
                      controller: emailController,
                      prefixIcon: const Icon(Icons.mail_outline),
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      validator: (value) => validateEmail(value),
                      enabled: false,
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
                      initialValue: initialPhoneNumber,
                    ),
                    SizedBoxes.verticalLarge,
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
                      selectedItem: university,
                      onChanged: onSchoolSelected,
                    ),
                  ]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              color:
                  Provider.of<PreMedProvider>(context, listen: false).isPreMed
                      ? PreMedColorTheme().red
                      : PreMedColorTheme().blue,
              buttonText: 'Save Changes',
              onPressed: onEditDetailsPressed,
            ),
            SizedBoxes.verticalBig,
            Padding(
              padding: const EdgeInsets.only(left: 64, right: 64),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Divider(
                  color: PreMedColorTheme().neutral300,
                  thickness: 1.5,
                ),
              ),
            ),
            SizedBoxes.verticalBig,
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            Provider.of<PreMedProvider>(context, listen: false)
                                    .isPreMed
                                ? PreMedColorTheme().red
                                : PreMedColorTheme().blue,
                        width: 2),
                    borderRadius: BorderRadius.circular(11)),
                child: CustomButton(
                  color: Provider.of<PreMedProvider>(context, listen: false)
                          .isPreMed
                      ? PreMedColorTheme().red
                      : PreMedColorTheme().blue,
                  buttonText: 'Delete account',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeleteAccount(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
