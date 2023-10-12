import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/UI/Widgets/or_divider.dart';
import 'package:premedpk_mobile_app/utils/Data/citites_data.dart';

class ExpertSolution extends StatelessWidget {
  const ExpertSolution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_back)),
                      SizedBoxes.horizontalExtraGargangua,
                      SizedBoxes.horizontalExtraGargangua,
                      Text(
                        'Ask an Expert',
                        style: PreMedTextTheme().heading6,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 2,
                              child: Image.network(
                                  'https://i.stack.imgur.com/TWror.png'),
                            ),
                            Positioned(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add_a_photo)),
                              bottom: 100,
                              left: 220,
                            )
                          ],
                        ),
                        SizedBoxes.verticalMedium,
                        const OrDivider(),
                        SizedBoxes.verticalMedium,
                        CustomButton(
                          buttonText: 'Open Camera & Take Photo',
                          onPressed: () {},
                        ),
                        SizedBoxes.verticalLarge,
                        Text(
                          'What problems are you facing in the uploaded question above? *',
                          style: PreMedTextTheme().subtext,
                        ),
                        SizedBoxes.verticalMedium,
                        CustomTextField(
                          maxLines: 6,
                          hintText: 'Enter questions here',
                        ),
                        SizedBoxes.verticalMedium,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select Resource',
                            style: PreMedTextTheme().subtext,
                          ),
                        ),
                        CityDropdownList(
                            items: cities_data,
                            selectedItem: cities_data[0],
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                print(newValue);
                              }
                            }),
                        SizedBoxes.verticalMedium,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'What subject is the question related to?',
                            style: PreMedTextTheme().subtext,
                          ),
                        ),
                        SizedBoxes.verticalMedium,
                        CityDropdownList(
                            items: cities_data,
                            selectedItem: cities_data[0],
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                print(newValue);
                              }
                            }),
                        SizedBoxes.verticalMedium,
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select Topic',
                            style: PreMedTextTheme().subtext,
                          ),
                        ),
                        SizedBoxes.verticalMedium,
                        CityDropdownList(
                            items: cities_data,
                            selectedItem: cities_data[0],
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                print(newValue);
                              }
                            }),
                        SizedBoxes.verticalMedium,
                        CustomButton(buttonText: 'Submit', onPressed: () {}),
                        SizedBoxes.verticalMicro,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BottomNavigator()
          ],
        ),
      ),
    );
  }
}
