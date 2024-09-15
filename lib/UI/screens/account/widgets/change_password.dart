import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../Dashboard_Screen/dashboard_screen.dart';

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
    final PreMedProvider preMedProvider = Provider.of<PreMedProvider>(context);

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
      backgroundColor: PreMedColorTheme().background,
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().background,
        leading: const PopButton(),
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
                  ? Center(
                child: Card(
                  elevation: 17,
                  child: Container(
                    height: 230,
                    width: 330,
                    decoration: BoxDecoration(
                        boxShadow: CustomBoxShadow.boxShadow40,
                        borderRadius: BorderRadius.circular(12),
                        color: PreMedColorTheme().background
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            PremedAssets.premedlogo,
                            height: 150,
                            width: 150,
                          ),
                          Text("You Signed In from Google\nYou can't change your password",
                            textAlign: TextAlign.center,
                            style: PreMedTextTheme().body.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: PreMedColorTheme().black
                            ),
                          ),
                          const SizedBox(height: 20,)
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  : Column(
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
                          color: preMedProvider.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
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
