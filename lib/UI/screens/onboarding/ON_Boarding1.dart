import 'package:premedpk_mobile_app/export.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
            padding: EdgeInsets.all(16),
            decoration: ShapeDecoration(
                color: PreMedColorTheme().white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: PreMedColorTheme().neutral400,
                    ),
                    borderRadius: BorderRadius.circular(8))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Parents Name'),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  hintText: 'Enter name here',
                ),
                SizedBoxes.verticalMedium,
                Text('Parents Number'),
                SizedBoxes.verticalMedium,
                CustomTextField(
                  hintText: '+92',
                ),
                SizedBoxes.verticalMedium,
                Text('What did you intend to use PreMed.PK for ?'),
                SizedBoxes.verticalMedium,
                Text('Have you joined any academy? ')
              ],
            ),
          ),
          SizedBoxes.verticalLarge,
          SizedBoxes.horizontalMicro,
          CustomButton(
            buttonText: '<- Back',
            onPressed: () {},
            isOutlined: true,
          ),
          SizedBoxes.verticalLarge,
          CustomButton(
            buttonText: 'Lets Start Learning! ->',
            onPressed: () {},
            isOutlined: true,
          )
        ],
      ),
    )));
  }
}
