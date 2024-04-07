import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/Widgets/school_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/school_data.dart';

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

  @override
  void initState() {
    fullNameController.text = userProvider.user!.fullName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    final TextEditingController parentNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Future<void> onEditDetailsPressed() async {
      final form = formKey.currentState!;
      if (form.validate()) {
        print(fullNameController.text);
        final Future<Map<String, dynamic>> response =
            userProvider.updateUserDetails(fullNameController.text);

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
      userProvider.setCity(selectedCity!);
    }

    void onSchoolSelected(String selectedSchool) {
      auth.setSchool(selectedSchool);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Account',
              style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBoxes.vertical2Px,
            Text(
                'SETTINGS',
                style: PreMedTextTheme().subtext.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: PreMedColorTheme().black,)
            )
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
                  ),
                  SizedBoxes.verticalMedium,
                  CustomTextField(
                    controller: emailController,
                    prefixIcon: const Icon(Icons.mail_outline),
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    validator: (value) => validateEmail(value),
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
                      selectedItem: auth.city,
                      onChanged: onCitySelected),
                  SizedBoxes.verticalMedium,
                  SchoolDropdownList(
                    items: schoolsdata,
                    selectedItem: auth.school,
                    onChanged: onSchoolSelected,
                  ),
                  SizedBoxes.verticalLarge,
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Parent's Information",
                      style: PreMedTextTheme().subtext1,
                    ),
                  ),
                  SizedBoxes.verticalTiny,
                  CustomTextField(
                    controller: parentNameController,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    labelText: "Parent/Guardian's Name",
                  ),
                  SizedBoxes.verticalTiny,
                  PhoneDropdown(
                    onPhoneNumberSelected: onPhoneNumberSelected,
                    hintText: "",
                    initialValue: auth.phoneNumber,
                  ),

                  SizedBoxes.verticalGargangua,
                  CustomButton(
                    buttonText: 'Save Changes',
                    onPressed: onEditDetailsPressed,
                  ),

                ],

              ),
            ),
          ),
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
