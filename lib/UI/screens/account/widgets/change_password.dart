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
        leading: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Change Password',
              style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().black,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBoxes.vertical2Px,
            Text(
                'SETTINGS',
                style: PreMedTextTheme().subtext.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: PreMedColorTheme().black,)
            )
          ],
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

                        SizedBoxes.verticalMicro,
                        CustomTextField(
                          prefixIcon: const Icon(Icons.lock_outline),
                          controller: oldPasswordController,
                          hintText: 'Old Password',
                          obscureText: true,
                        ),
                        SizedBoxes.verticalMedium,

                        CustomTextField(
                          prefixIcon: const Icon(Icons.lock_outline),
                          controller: newPasswordController,
                          hintText: 'New Password',
                          validator: newPasswordValidator,
                          obscureText: true,
                        ),

                        SizedBoxes.verticalMedium,

                        CustomTextField(
                          prefixIcon: const Icon(Icons.lock_outline),
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
                          buttonText: 'Save Changes',
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
