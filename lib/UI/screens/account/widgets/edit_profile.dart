import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    void onPhoneNumberSelected(PhoneNumber phoneNumber) {
      auth.parentContactNumber = phoneNumber.completeNumber;
    }

    void onCitySelected(String? selectedCity) {
      auth.setCity(selectedCity!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        title: Text(
          'Edit Profile',
          style: PreMedTextTheme().heading7.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: PreMedColorTheme().black, // Set the color for the icon
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: PreMedTextTheme().body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBoxes.verticalMedium,
            const CustomTextField(
              hintText: 'baig.ebrahim@gmail.com',
            ),
            SizedBoxes.verticalMedium,
            Text('Phone Number',
                style: PreMedTextTheme().body.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
            SizedBoxes.verticalMedium,
            PhoneDropdown(
              onPhoneNumberSelected: onPhoneNumberSelected,
              hintText: "Contact Number",
            ),
            Text('City',
                style: PreMedTextTheme().body.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
            SizedBoxes.verticalMedium,
            CityDropdownList(
              items: cities,
              selectedItem: auth.city,
              onChanged: onCitySelected,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 329.0),
              child: CustomButton(
                buttonText: 'Save Changes',
                onPressed: () {},
              ),
            )
          ],
        ),
      )),
    );
  }
}
