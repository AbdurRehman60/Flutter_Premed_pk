import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    onchangepasswordpressed() {}
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
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UserProvider().user?.accountType == "google"
              ? const Center(
                  child: Text(
                    "You signed in from google, You can't change your password.",
                    textAlign: TextAlign.center,
                  ),
                )
              : Column(
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
                    SizedBoxes.verticalTiny,
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
                    SizedBoxes.verticalTiny,
                    const CustomTextField(
                      hintText: 'Confirm New Password',
                    ),
                    SizedBoxes.verticalGargangua,
                    CustomButton(
                      buttonText: 'Change Password',
                      onPressed: onchangepasswordpressed,
                    )
                  ],
                ),
        ),
      )),
    );
  }
}
