import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/check_box.dart';
import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/curve_painter.dart';
import 'package:premedpk_mobile_app/export.dart';

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
                  SizedBoxes.verticalTiny,
                  Text(
                    'Complete the Final Form and Get Started',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().neutral500),
                  ),
                  SizedBoxes.verticalExtraGargangua,
                  OptionalOnboardingForm(),
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
                          buttonText: "Let's Start Learning!",
                          isIconButton: true,
                          color: PreMedColorTheme().white,
                          textColor: PreMedColorTheme().neutral600,
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

class OptionalOnboardingForm extends StatelessWidget {
  OptionalOnboardingForm({super.key});

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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBoxes.verticalMedium,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Parents Name:',
                  style: PreMedTextTheme().subtext,
                ),
              ),
              SizedBoxes.verticalMedium,
              const CustomTextField(
                hintText: 'Enter Parents name',
              ),
              SizedBoxes.verticalMedium,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Parents Phone Number',
                  style: PreMedTextTheme().subtext,
                ),
              ),
              SizedBoxes.verticalMedium,
              PhoneDropdown(),
              SizedBoxes.verticalLarge,
              Text(
                'What did you intend to use PreMed.PK for ?',
                style: PreMedTextTheme().heading6,
              ),
              SizedBoxes.verticalMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomCheckBox(),
                  SizedBoxes.horizontalTiny,
                  Text(
                    'MDCAT',
                    style: PreMedTextTheme().subtext,
                  ),
                  SizedBoxes.horizontalBig,
                  const CustomCheckBox(),
                  SizedBoxes.horizontalTiny,
                  Text('AKU', style: PreMedTextTheme().subtext),
                  SizedBoxes.horizontalBig,
                  const CustomCheckBox(),
                  SizedBoxes.horizontalTiny,
                  Text('NUMS', style: PreMedTextTheme().subtext)
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
                        activeColor: PreMedColorTheme().primaryColorRed,
                        visualDensity: VisualDensity.compact,
                      ),
                      Text(
                        option,
                        style: PreMedTextTheme().subtext,
                      ),
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
