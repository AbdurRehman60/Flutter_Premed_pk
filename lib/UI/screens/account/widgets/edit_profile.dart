import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserProvider userProvider =
      UserProvider(); // Create an instance of UserProvider

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    void onEditDetailsPressed() async {
      final form = _formKey.currentState!;
      if (form.validate()) {
        try {
          // Assuming you have a method in UserProvider to update the full name
          await userProvider
              .updateFullName(UserProvider().user?.fullName ?? '');

          // Show a success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Details updated successfully!'),
            ),
          );
        } catch (error) {
          // Show an error SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update details. Please try again.'),
            ),
          );
          print('Error updating details: $error');
        }
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
