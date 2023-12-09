import 'package:premedpk_mobile_app/UI/screens/account/widgets/change_password.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/contact_us.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/edit_profile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/menu_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);
  void onLogoutPressed() async {
    // Call the logout function from the provider
    // final result = await AuthProvider().logout();

    // Handle the result accordingly
    // if (result['status'] == true) {
    //   // Logout was successful
    //   // You may want to navigate to the login screen or perform any additional actions
    //   print('Logout successful');
    // } else {
    //   // Logout failed, display an error message or handle accordingly
    //   print('Logout failed: ${result['message']}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    String username = 'Ebrahim Baig';

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: PreMedColorTheme().primaryColorRed,
              child: Text(
                username.isNotEmpty ? username[0] : '', // Take the first letter
                style: PreMedTextTheme().heading1.copyWith(
                      color: PreMedColorTheme().white,
                    ),
              ),
              maxRadius: 60,
            ),
            SizedBoxes.verticalMedium,
            Text(
              username,
              style: PreMedTextTheme().heading5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  PremedAssets.Coins,
                  width: 16,
                  height: 16,
                  fit: BoxFit.fill,
                ),
                SizedBoxes.horizontal2Px,
                Text(
                  '500',
                  style: PreMedTextTheme().body,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  String heading = '';
                  String imagePath = '';

                  // Updated switch statement to set heading and imagePath
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

                  return Column(
                    children: [
                      Divider(
                        color: PreMedColorTheme().neutral200,
                      ),
                      // Use MenuTile with onTap
                      MenuTile(
                        heading: heading,
                        icon: imagePath,
                        onTap: () {
                          // Handle onTap based on index
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
                                  builder: (context) => ContactUs(
                                    btnColor: Colors.green,
                                    btnColor1: Color(0xFF039DFD),
                                    btnColor2: Color(0xFFFBA028),
                                  ),
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
                      ),
                      if (index == 4)
                        Divider(
                          color: PreMedColorTheme().neutral200,
                        ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 312,
                height: 50,
                child: TextButton(
                  onPressed: onLogoutPressed,
                  style: TextButton.styleFrom(
                    backgroundColor:
                        PreMedColorTheme().primaryColorRed, // Background color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        PremedAssets.LogOut,
                        width: 16,
                        height: 18,
                      ),
                      SizedBoxes.horizontalMicro,
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: PreMedColorTheme().white, // Text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
