import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/curve_painter.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/ui/screens/onboarding/widgets/check_box.dart';
import 'package:premedpk_mobile_app/utils/Data/country_code_data.dart';

class OptionalOnboarding extends StatelessWidget {
  const OptionalOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(gradient: PreMedColorTheme().primaryGradient),
        ),
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: CustomPaint(
              painter: CurvePainter(),
            )),
        Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBoxes.verticalBig,
                  Text(
                    'You are Almost there!',
                    style: PreMedTextTheme()
                        .heading3
                        .copyWith(color: PreMedColorTheme().primaryColorRed),
                  ),
                  SizedBoxes.verticalMicro,
                  Text(
                    'Complete the Final Form and Get Started',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().neutral500),
                  ),
                  SizedBoxes.verticalLarge,
                  saadOptionalOnboarding(),
                  SizedBoxes.verticalGargangua,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          buttonText: '',
                          isOutlined: true,
                          isIconButton: true,
                          icon: Icons.arrow_back,
                          leftIcon: false,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RequiredOnboarding(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBoxes.horizontalMedium,
                      Expanded(
                        flex: 7,
                        child: CustomButton(
                          buttonText: "Let's Start Learning",
                          isIconButton: true,
                          icon: Icons.arrow_forward,
                          leftIcon: false,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const OptionalOnboarding(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    )));
  }
}

List<String> options = [
  'Yes',
  'No',
];

class saadOptionalOnboarding extends StatelessWidget {
  saadOptionalOnboarding({super.key});

  @override
  String currentOption = options[0];
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreMedColorTheme().white,
        border: Border.all(
          color: PreMedColorTheme().neutral300,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBoxes.verticalMedium,
              CustomTextField(
                labelText: 'Father Name',
                hintText: 'Enter name here',
              ),
              SizedBoxes.verticalMedium,
              Align(
                alignment: Alignment.topLeft,
                child: CountryCode(
                    items: countryPhoneCodes,
                    selectedItem: countryPhoneCodes[41],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        print(newValue);
                      }
                    }),
              ),
              CustomTextField(
                hintText: '303xxxxxxxx',
                labelText: 'Contact Number',
              ),
              SizedBoxes.verticalLarge,
              Text(
                'What did you intend to use PreMed.PK for ?',
                style: PreMedTextTheme().heading6,
              ),
              SizedBoxes.verticalMedium,
              Row(
                children: [
                  ChecBox(),
                  Text('MDCAT'),
                  SizedBoxes.horizontalMicro,
                  ChecBox(),
                  Text('AKU'),
                  SizedBoxes.horizontalMedium,
                  ChecBox(),
                  Text('NUMS')
                ],
              ),
              SizedBoxes.verticalMedium,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Have you joined any academy?',
                  style: PreMedTextTheme().heading6,
                ),
              ),
              SizedBoxes.verticalLarge,
              Row(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Align content to the left // Align text to the left
                children: options.map((option) {
                  return Row(
                    children: [
                      Radio(
                        value: option,
                        groupValue: currentOption,
                        onChanged: (value) {
                          setState(() {
                            currentOption = value.toString();
                          });
                        },
                      ),
                      Text(option),
                    ],
                  );
                }).toList(),
              ),
            ],
          )),
    );
  }

  void setState(Null Function() param0) {}
}
