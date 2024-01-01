import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserProvider userProvider =
      UserProvider(); // Create an instance of UserProvider
  final TextEditingController fullNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    void onEditDetailsPressed() async {
      final form = _formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> response =
            userProvider.updateUserDetails(fullNameController.text);

        response.then(
          (response) {
            if (response['status']) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => response['message'] == 'onboarding'
              //         ? const RequiredOnboarding()
              //         : const MainNavigationScreen(),
              //   ),
              // );
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        title: Text(
          'Account',
          style: PreMedTextTheme().heading7.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: PreMedColorTheme().black, // Set the color for the icon
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: PreMedTextTheme().body.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBoxes.verticalTiny,
                  CustomTextField(
                    initialValue: userProvider.user?.fullName,
                    // controller: fullNameController,
                  ),
                  SizedBoxes.verticalMedium,
                  Text(
                    'Phone Number',
                    style: PreMedTextTheme().body.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBoxes.verticalTiny,
                  PhoneDropdown(
                    onPhoneNumberSelected: onPhoneNumberSelected,
                    hintText: "Contact Number",
                    initialValue: userProvider.user?.phoneNumber,
                  ),
                  Text(
                    'City',
                    style: PreMedTextTheme().body.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBoxes.verticalTiny,
                  CityDropdownList(
                    items: cities,
                    selectedItem: userProvider.user?.city ?? '',
                    onChanged: onCitySelected,
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
