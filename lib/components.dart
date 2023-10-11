import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/widgets/custom_button.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:premedpk_mobile_app/utils/Data/country_code_data.dart';
import 'package:premedpk_mobile_app/utils/Data/school_data.dart';

class ComponentScreen extends StatelessWidget {
  const ComponentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // CustomButton(
                //   buttonText: "Filled Button",
                //   onPressed: () {},
                // ),
                // SizedBoxes.verticalBig,
                // CustomButton(
                //     buttonText: "Outlined Button",
                //     onPressed: () {},
                //     isOutlined: true),
                // SizedBoxes.verticalBig,
                // CustomButton(
                //   buttonText: "Icon Button",
                //   onPressed: () {},
                //   isIconButton: true,
                //   icon: Icons.abc,
                //   iconSize: 40,
                // ),
                SizedBoxes.verticalBig,
                Container(
                  height: 45,
                  width: MediaQuery.sizeOf(context).width,
                  decoration:
                      BoxDecoration(color: PreMedColorTheme().primaryColorRed),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PreMedColorTheme().primaryColorRed',
                        style: PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white),
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalMicro,
                Container(
                  height: 45,
                  width: MediaQuery.sizeOf(context).width,
                  decoration:
                      BoxDecoration(color: PreMedColorTheme().primaryColorBlue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PreMedColorTheme().primaryColorBlue',
                        style: PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      gradient: PreMedColorTheme().primaryRedGradient),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'primaryRedGradient',
                        style: PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white),
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalBig,
                CustomTextField(
                  hintText: 'email',
                  labelText: 'John.doe@gmail.com',
                ),
                SizedBoxes.verticalLarge,
                // CountryCodePickerWidget(),
                SchoolDropdownList(
                    items: schools_data,
                    selectedItem: schools_data[0],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        print(newValue);
                      }
                    }),
                CityDropdownList(
                    items: cities_data,
                    selectedItem: cities_data[0],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        print(newValue);
                      }
                    }),
                SizedBoxes.verticalLarge,
                // CountryCode(
                //     items: countryPhoneCodes,
                //     selectedItem: countryPhoneCodes[0],
                //     onChanged: (String? newValue) {
                //       if (newValue != null) {
                //         print(newValue);
                //       }
                //     })
                // const CountryCodePickerWidget(),
                // CountryCodePickerWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
