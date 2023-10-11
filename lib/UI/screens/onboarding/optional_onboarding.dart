import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/ui/screens/onboarding/widgets/check_box.dart';
import 'package:premedpk_mobile_app/utils/Data/country_code_data.dart';

class OptionalOnboarding extends StatelessWidget {
  const OptionalOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Parents Name',
                style: PreMedTextTheme().heading6,
              ),
            ),
            SizedBoxes.verticalMedium,
            CustomTextField(
              hintText: 'Enter name here',
            ),
            SizedBoxes.verticalMedium,
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Parents Number',
                style: PreMedTextTheme().heading6,
              ),
            ),
            SizedBoxes.verticalMedium,
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
            ),
            SizedBoxes.verticalLarge,
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'What did you intend to use PreMed.PK for ?',
                  style: PreMedTextTheme().heading6,
                )),
            SizedBoxes.verticalMedium,
            Row(
              children: [
                ChecBox(),
                Text('NUMS'),
                SizedBoxes.horizontalMedium,
                ChecBox(),
                Text('AKU'),
                SizedBoxes.horizontalMedium,
                ChecBox(),
                Text('MDCAT')
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
              children: [
                ChecBox(),
                Text('Yes'),
                SizedBoxes.horizontalMedium,
                ChecBox(),
                Text('No')
              ],
            ),
            SizedBoxes.verticalBig,
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
                          builder: (context) => const RequiredOnboarding(),
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
                          builder: (context) => const OptionalOnboarding(),
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
    )));
  }
}
