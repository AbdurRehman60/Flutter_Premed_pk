import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        title: Text(
          'Change Password',
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
              'Old Password',
              style: PreMedTextTheme().body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBoxes.verticalMicro,
            const CustomTextField(
              hintText: 'Old Password',
            ),
            SizedBoxes.verticalMedium,
            Text(
              'New Password',
              style: PreMedTextTheme().body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBoxes.verticalMicro,
            const CustomTextField(
              hintText: 'New Password',
            ),
            SizedBoxes.verticalMedium,
            Text(
              'Confirm New Password',
              style: PreMedTextTheme().body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBoxes.verticalMicro,
            const CustomTextField(
              hintText: 'Confirm New Password',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 378),
              child: CustomButton(
                buttonText: 'Change Password',
                onPressed: () {},
              ),
            )
          ],
        ),
      )),
    );
  }
}
