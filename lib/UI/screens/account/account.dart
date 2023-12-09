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
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = 'Ebrahim Baig';
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void onLogoutPressed() async {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBoxes.verticalGargangua,
          CircleAvatar(
            backgroundColor: PreMedColorTheme().primaryColorRed100,
            maxRadius: 60,
            child: Text(
              username.isNotEmpty ? username[0] : '',
              style: PreMedTextTheme().heading1.copyWith(
                    color: PreMedColorTheme().white,
                  ),
            ),
          ),
          SizedBoxes.verticalMedium,
          Text(
            username,
            style: PreMedTextTheme().heading5,
          ),
          SizedBoxes.verticalTiny,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                PremedAssets.Coins,
                width: 16,
                height: 16,
                fit: BoxFit.fill,
              ),
              SizedBoxes.horizontalMicro,
              Text(
                '500',
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
                    heading = 'Edit Profile';
                    imagePath = PremedAssets.EditProfile;
                    break;
                  case 1:
                    heading = 'Change Password';
                    imagePath = PremedAssets.ChangePassword;
                    break;
                  case 2:
                    heading = 'Contact Us';
                    imagePath = PremedAssets.ContactUs;
                    break;
                  case 3:
                    heading = 'Privacy Policy';
                    imagePath = PremedAssets.Policy;
                    break;
                  case 4:
                    heading = 'Terms & Condition';
                    imagePath = PremedAssets.Policy;
                    break;
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
                        break;
                      case 1:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChangePassword(),
                          ),
                        );
                        break;
                      case 2:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ContactUs(),
                          ),
                        );
                        break;
                      case 3:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy(),
                          ),
                        );
                        break;
                      case 4:
                        // Handle Terms & Condition tap
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TermsCondition(),
                          ),
                        );
                        break;
                    }
                  },
                );
              },
            ),
          ),

          // MenuTile(
          //   heading: 'Edit Profile',
          //   icon: PremedAssets.EditProfile,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const EditProfile(),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Change Password',
          //   icon: PremedAssets.ChangePassword,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const ChangePassword(),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Contact Us',
          //   icon: PremedAssets.ContactUs,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const ContactUs(
          //           btnColor: Colors.green,
          //           btnColor1: Color(0xFF039DFD),
          //           btnColor2: Color(0xFFFBA028),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Privacy Policy',
          //   icon: PremedAssets.Policy,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const PrivacyPolicy(),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Terms & Condition',
          //   icon: PremedAssets.Policy,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const TermsCondition(),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Edit Profile',
          //   icon: PremedAssets.EditProfile,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const EditProfile(),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Change Password',
          //   icon: PremedAssets.ChangePassword,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const ChangePassword(),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Contact Us',
          //   icon: PremedAssets.ContactUs,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const ContactUs(
          //           btnColor: Colors.green,
          //           btnColor1: Color(0xFF039DFD),
          //           btnColor2: Color(0xFFFBA028),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Privacy Policy',
          //   icon: PremedAssets.Policy,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const PrivacyPolicy(),
          //       ),
          //     );
          //   },
          // ),
          // MenuTile(
          //   heading: 'Terms & Condition',
          //   icon: PremedAssets.Policy,
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const TermsCondition(),
          //       ),
          //     );
          //   },
          // ),

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
      ),
    );
  }
}
