import 'package:premedpk_mobile_app/UI/screens/account/widgets/change_password.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/contact_us.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/edit_profile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/menu_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';
import 'package:premedpk_mobile_app/UI/screens/login/login.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/marketplace_home.dart';
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            backgroundColor: PreMedColorTheme().white,
            title: Padding(
              padding: const EdgeInsets.only(left: 6.0, top: 28, bottom: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: PreMedTextTheme().heading6.copyWith(
                          color: PreMedColorTheme().black,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  SizedBoxes.vertical2Px,
                  Text('Your App and Account Preferences',
                      style: PreMedTextTheme().subtext.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: PreMedColorTheme().black,
                          ))
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: PreMedColorTheme().primaryColorRed, width: 8)),
                  child: CircleAvatar(
                    backgroundColor: PreMedColorTheme().primaryColorRed100,
                    maxRadius: 55,
                    child: Text(
                      userProvider.getUserName()[0].toUpperCase(),
                      style: PreMedTextTheme().heading1.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.w800,
                          fontSize: 55),
                    ),
                  ),
                ),
                SizedBoxes.verticalTiny,
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MarketPlace(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                  ),
                ),
                SizedBoxes.verticalMedium,
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
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
                        case 3: // Logout Button
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child:
                                  auth.loggedInStatus == Status.Authenticating
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.0,
                                              ),
                                            ),
                                            SizedBoxes.horizontalMedium,
                                            Text(
                                              'Logging Out',
                                              style: PreMedTextTheme().subtext,
                                            ),
                                          ],
                                        )
                                      : CustomButton(
                                          buttonText: 'Sign out',
                                          onPressed: onLogoutPressed,
                                        ),
                            ),
                          );
                        case 4:
                          heading = 'Privacy Policy';
                          imagePath = 'assets/icons/Privacy Shield Tick.png';
                        case 5:
                          heading = 'Terms of Use';
                          imagePath = PremedAssets.Terms;
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: PreMedColorTheme().white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: MenuTile(
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
                                    builder: (context) =>
                                        const ChangePassword(),
                                  ),
                                );
                              case 2:
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ContactUs(),
                                  ),
                                );

                              case 4:
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const PrivacyPolicy(),
                                  ),
                                );
                              case 5:
                                // Handle Terms & Condition tap
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TermsCondition(),
                                  ),
                                );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
