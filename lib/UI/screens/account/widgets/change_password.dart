import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    void onchangepasswordpressed() async {
      if (_formKey.currentState?.validate() ?? false) {
        final String oldPassword = oldPasswordController.text.trim();
        final String newPassword = newPasswordController.text.trim();
        final String confirmNewPassword =
            confirmNewPasswordController.text.trim();

        // Check if new password and confirm new password match
        if (newPassword != confirmNewPassword) {
          // Show an error message or handle the mismatch
          return;
        }

        // Call the updatePassword method from UserProvider
        await userProvider.updateUserDetails();

        // You can add more logic here based on the result of the updatePassword method
      }
    }

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
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                        CustomTextField(
                          controller: oldPasswordController,
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
                        CustomTextField(
                          controller: newPasswordController,
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
                        CustomTextField(
                          controller: confirmNewPasswordController,
                          hintText: 'Confirm New Password',
                        ),
                        SizedBoxes.verticalGargangua,
                        CustomButton(
                          buttonText: 'Change Password',
                          onPressed: onchangepasswordpressed,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
