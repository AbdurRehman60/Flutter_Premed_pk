import 'package:premedpk_mobile_app/export.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(children: [
          Column(
            children: [
              Text(
                'Welcome Aboard',
                style: PreMedTextTheme()
                    .heading3
                    .copyWith(color: PreMedColorTheme().primaryColorRed),
              ),
              Text(
                'Just One More Step to Begin Your Journey in Medicine.',
                style: PreMedTextTheme()
                    .subtext
                    .copyWith(color: PreMedColorTheme().neutral500),
              ),
              Container(
                // height: 488,
                // width: 486,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                decoration: ShapeDecoration(
                    color: PreMedColorTheme().white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: PreMedColorTheme().black,
                        ),
                        borderRadius: BorderRadius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Number',
                        style: PreMedTextTheme().subtext,
                        // textAlign: TextAlign.start,
                      ),
                      SizedBoxes.verticalTiny,
                      CustomTextField(
                        hintText: 'Contact Number',
                      ),
                      // Row(
                      //   children: [
                      //     CustomTextField(
                      //       hintText: 'Contact Number',
                      //     ),
                      //   ],
                      // ),
                      SizedBoxes.verticalTiny,
                      Text(
                        'City',
                        style: PreMedTextTheme().subtext,
                      ),
                      SizedBoxes.verticalTiny,
                      CustomTextField(
                        hintText: 'City here',
                      ),
                      SizedBoxes.verticalTiny,
                      Text('School Name'),
                      SizedBoxes.verticalTiny,
                      CustomTextField(
                        hintText: 'School here',
                      ),
                      SizedBoxes.verticalTiny,
                      Text('Which year are you in?'),
                      SizedBoxes.verticalMedium,
                      BulletButton(
                        text: 'FSc 1st Year/AS Level',
                        isSelected: true,
                        onChanged: (bool value) {},
                      ),
                      BulletButton(
                        text: 'FSc 2nd Year/AS Level',
                        isSelected: true,
                        onChanged: (bool value) {},
                      ),
                      BulletButton(
                        text: 'Have given MDCAT & improving',
                        isSelected: true,
                        onChanged: (bool value) {},
                      )
                      // Text('FSc 1st Year/AS Level'),
                      // SizedBoxes.verticalTiny,
                      // Text('FSc 2nd Year/A2 Level'),
                      // SizedBoxes.verticalTiny,
                      // Text('Have given MDCAT & Improving'),
                      // SizedBoxes.verticalTiny,
                      // CustomBulletButtons()

                      // WhatsAppAvailability(),
                      // Row(
                      //   children: [
                      //     CustomTextField(
                      //       hintText: 'Contact Number',
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
              SizedBoxes.verticalMedium,
              CustomButton(buttonText: 'Next ->', onPressed: () {})
            ],
          ),
        ]),
      )),
    );
  }
}
