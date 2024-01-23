import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    void onchangepasswordpressed() {
      final form = _formKey.currentState!;

      if (form.validate()) {
        final String oldPassword = oldPasswordController.text.trim();
        final String newPassword = newPasswordController.text.trim();

        final Future<Map<String, dynamic>> response =
            userProvider.changePassword(
          oldPassword,
          newPassword,
        );
        response.then(
          (response) {
            if (response['status']) {
              showSnackbar(
                context,
                "Password Updated",
                SnackbarType.SUCCESS,
                navigate: true,
              );
            } else {
              showError(context, response);
            }
          },
        );
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
                          obscureText: true,
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
                          validator: newPasswordValidator,
                          obscureText: true,
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
                          validator: (value) => confirmNewPasswordValidator(
                            value!,
                            newPasswordController.text,
                          ),
                          obscureText: true,
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

  String? newPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password cannot be empty';
    }
    // Add more validation rules as needed
    return null;
  }

  String? confirmNewPasswordValidator(String value, String newPassword) {
    if (value.isEmpty) {
      return 'Confirm new password cannot be empty';
    }
    if (value != newPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
