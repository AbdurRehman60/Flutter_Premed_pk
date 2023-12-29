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

    void onchangepasswordpressed(BuildContext context) async {
      final form = _formKey.currentState!;
      if (form.validate()) {
        try {
          // Assuming you have a method in UserProvider to update the password
          await userProvider.updatePassword(newPasswordController.text);

          // Show a success SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password changed successfully!'),
            ),
          );
        } catch (error) {
          // Show an error SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to change password. Please try again.'),
            ),
          );
          print('Error changing password: $error');
        }
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
                          onPressed: () => onchangepasswordpressed(context),
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
