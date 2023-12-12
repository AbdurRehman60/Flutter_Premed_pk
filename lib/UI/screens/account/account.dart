import 'package:premedpk_mobile_app/UI/screens/account/widgets/change_password.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/contact_us.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/edit_profile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/menu_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';
import 'package:premedpk_mobile_app/UI/screens/login/login.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    Future<void> onLogoutPressed() async {
      final Future<Map<String, dynamic>> response = auth.logout();

      response.then(
        (response) {
          if (response['status']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          } else {
            showError(context, response);
          }
        },
      );
    }

    return SafeArea(
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBoxes.verticalGargangua,
              CircleAvatar(
                backgroundColor: PreMedColorTheme().primaryColorRed100,
                maxRadius: 60,
                child: Text(
                  userProvider.getUserName()[0].toUpperCase(),
                  style: PreMedTextTheme().heading1.copyWith(
                        color: PreMedColorTheme().primaryColorRed300,
                      ),
                ),
              ),
              SizedBoxes.verticalMedium,
              Text(
                userProvider.getUserName().split(' ').length > 1
                    ? '${userProvider.getUserName().split(' ').first} ${userProvider.getUserName().split(' ')[1]}'
                    : userProvider.getUserName().split(' ').first,
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalTiny,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    PremedAssets.Coins,
                    width: 16,
                    height: 16,
                    fit: BoxFit.fill,
                  ),
                  SizedBoxes.horizontalMicro,
                  Text(
                    userProvider.getCoins().toString(),
                    style: PreMedTextTheme().body,
                  ),
                ],
              ),
              SizedBoxes.verticalMedium,
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    String heading = '';
                    String imagePath = '';

                    switch (index) {
                      case 0:
                        heading = 'Account';
                        imagePath = PremedAssets.EditProfile;
                      case 1:
                        heading = 'Change Password';
                        imagePath = PremedAssets.ChangePassword;
                      case 2:
                        heading = 'Contact Us';
                        imagePath = PremedAssets.ContactUs;
                      case 3:
                        heading = 'Privacy Policy';
                        imagePath = PremedAssets.Policy;
                      case 4:
                        heading = 'Terms & Condition';
                        imagePath = PremedAssets.Policy;
                    }

                    return MenuTile(
                      heading: heading,
                      icon: imagePath,
                      onTap: () {
                        switch (index) {
                          case 0:
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const EditProfile(),
                              ),
                            );
                          case 1:
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ChangePassword(),
                              ),
                            );
                          case 2:
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ContactUs(),
                              ),
                            );
                          case 3:
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PrivacyPolicy(),
                              ),
                            );
                          case 4:
                            // Handle Terms & Condition tap
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TermsCondition(),
                              ),
                            );
                        }
                      },
                    );
                  },
                ),
              ),
              SizedBoxes.verticalMedium,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    buttonText: 'Logout',
                    onPressed: onLogoutPressed,
                    isIconButton: true,
                    icon: Icons.logout,
                    fontSize: 18,
                    iconSize: 20,
                  ),
                ),
              ),
              SizedBoxes.verticalBig,
            ],
          );
        },
      ),
    );
  }
}
