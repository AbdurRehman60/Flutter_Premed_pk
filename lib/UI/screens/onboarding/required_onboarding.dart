import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';
import 'package:premedpk_mobile_app/utils/Data/country_code_data.dart';
import 'package:premedpk_mobile_app/utils/Data/school_data.dart';

class RequiredOnboarding extends StatelessWidget {
  const RequiredOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Welcome Aboard',
                  style: PreMedTextTheme()
                      .heading3
                      .copyWith(color: PreMedColorTheme().primaryColorRed),
                ),
              ),
              SizedBoxes.verticalLarge,
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Just One More Step to Begin Your Journey in Medicine.',
                  style: PreMedTextTheme()
                      .subtext
                      .copyWith(color: PreMedColorTheme().neutral500),
                ),
              ),
              SizedBoxes.verticalLarge,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Contact Number',
                  textAlign: TextAlign.start,
                  style: PreMedTextTheme().subtext,
                  // textAlign: TextAlign.start,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: CountryCode(
                    items: countryPhoneCodes,
                    selectedItem: countryPhoneCodes[0],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        print(newValue);
                      }
                    }),
              ),
              CustomTextField(
                  hintText: 'Contact Number',
                  onPressed: () {
                    print('Hello');
                  }),
              // CountryCodePickerWidget(), widget causing some issues
              // SizedBoxes.verticalTiny,

              SizedBoxes.verticalLarge,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'City',
                  style: PreMedTextTheme().subtext,
                ),
              ),
              SizedBoxes.verticalTiny,
              CityDropdownList(
                  items: cities_data,
                  selectedItem: cities_data[0],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      print(newValue);
                    }
                  }),
              SizedBoxes.verticalLarge,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'School Name',
                  textAlign: TextAlign.start,
                  style: PreMedTextTheme().subtext,
                ),
              ),
              SizedBoxes.verticalLarge,
              SchoolDropdownList(
                  items: schools_data,
                  selectedItem: schools_data[0],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      print(newValue);
                    }
                  }),
              SizedBoxes.verticalLarge,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Which year are you in?',
                  style: PreMedTextTheme().subtext,
                ),
              ),
              SizedBoxes.verticalLarge,
              RadioButtons(),
              CustomButton(
                buttonText: 'Next ->',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OptionalOnboarding(),
                      ));
                },
                isOutlined: true,
              )
            ],
          ),
        ),
      )),
    );
  }
}
