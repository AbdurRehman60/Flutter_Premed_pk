import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/widgets/cities_data_widget.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

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
      body: SafeArea(
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
                initialValue: UserProvider().user?.userName,
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
                initialValue: UserProvider().user?.phoneNumber,
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
                selectedItem: UserProvider().user?.city ?? '',
                onChanged: onCitySelected,
              ),
              SizedBoxes.verticalGargangua,
              // CustomButton(
              //   buttonText: 'Save Changes',
              //   onPressed: () {},
              // )
            ],
          ),
        ),
      )),
    );
  }
}
