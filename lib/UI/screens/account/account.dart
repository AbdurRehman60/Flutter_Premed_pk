import 'package:premedpk_mobile_app/UI/screens/Login/login_screen_one.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/account_before_edit.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/change_password.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/contact_us.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/credits.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/menu_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/privacy_policy.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/terms_conditions.dart';
import 'package:premedpk_mobile_app/UI/screens/notifications/notifications.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/error_dialogue.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    final isPremed = Provider.of<PreMedProvider>(context).isPreMed;
    Future<void> onLogoutPressed() async {
      try {
        // Start the logout process and wait for its completion
        print('Initiating logout process...');
        final Map<String, dynamic> response = await auth.logout();
        print('Logout response: $response');
        if (response['status'] == true) {
          print('Logout successful. Navigating to SignIn screen...');

          // Navigate to the SignIn screen after successful logout
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignIn(),
            ),
          );

          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.clear();
          print('SharedPreferences cleared successfully.');
        } else {
          print('Logout failed with response: $response');
          showError(context, response);
        }
      } catch (e) {
        print('Exception during logout: $e');
        showError(context, {'message': 'An error occurred during logout'});
      }
    }


    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90.0),
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 3),
          child: AppBar( centerTitle: false,
            backgroundColor: PreMedColorTheme().background,
            title: Column(
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
                Text(
                  'Your App and Account Preferences',
                  style: PreMedTextTheme().subtext.copyWith(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w400,
                        color: PreMedColorTheme().black,
                      ),
                )
              ],
            ),
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     border: Border.all(
                  //         color: PreMedColorTheme().primaryColorRed, width: 8),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.1),
                  //         spreadRadius: 3,
                  //         blurRadius: 5,
                  //       ),
                  //     ],
                  //   ),
                  //   child: CircleAvatar(
                  //     backgroundColor: PreMedColorTheme().primaryColorRed100,
                  //     maxRadius: 55,
                  //     child: Text(
                  //       userProvider.getUserName()[0].toUpperCase(),
                  //       style: PreMedTextTheme().heading1.copyWith(
                  //           color: PreMedColorTheme().primaryColorRed,
                  //           fontWeight: FontWeight.w800,
                  //           fontSize: 55),
                  //     ),
                  //   ),
                  // ),
                  // SizedBoxes.verticalLarge,
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 16.0, right: 16),
                  //   child: Row(
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => const MarketPlace(),
                  //             ),
                  //           );
                  //         },
                  //         child: Container(
                  //           width: 90,
                  //           decoration: BoxDecoration(
                  //             color: PreMedColorTheme().neutral100,
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(
                  //                 color: PreMedColorTheme().white, width: 2),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.black.withOpacity(0.1),
                  //                 spreadRadius: 1,
                  //                 blurRadius: 5,
                  //               ),
                  //             ],
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(12.0),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Image.asset(
                  //                   PremedAssets.Coins,
                  //                   width: 16,
                  //                   height: 16,
                  //                   fit: BoxFit.fill,
                  //                 ),
                  //                 SizedBoxes.horizontalMicro,
                  //                 Text(
                  //                   userProvider.getCoins().toString(),
                  //                   style: PreMedTextTheme().body.copyWith(
                  //                       fontSize: 15,
                  //                       fontWeight: FontWeight.w800),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBoxes.horizontalMedium,
                  //       InkWell(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => const MarketPlace(),
                  //             ),
                  //           );
                  //         },
                  //         child: Container(
                  //           width: MediaQuery.of(context).size.width * 0.6,
                  //           decoration: BoxDecoration(
                  //             color: PreMedColorTheme().neutral100,
                  //             borderRadius: BorderRadius.circular(15),
                  //             border: Border.all(
                  //                 color: PreMedColorTheme().white, width: 2),
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.black.withOpacity(0.1),
                  //                 spreadRadius: 1,
                  //                 blurRadius: 5,
                  //               ),
                  //             ],
                  //           ),
                  //           // child: Padding(
                  //           //   padding: const EdgeInsets.all(12.0),
                  //           //   child: Row(
                  //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           //     children: [
                  //           //       SizedBoxes.horizontalMicro,
                  //           //       Text(
                  //           //         userProvider.getIntendFor(),
                  //           //         style: PreMedTextTheme().body.copyWith(fontWeight: FontWeight.w800, fontSize: 13),
                  //           //       ),
                  //           //       const Spacer(),
                  //           //       Text('ACTIVE',style: PreMedTextTheme().body.copyWith(color: PreMedColorTheme().tickcolor, fontSize:10, fontWeight: FontWeight.w600 ),)
                  //           //     ],
                  //           //   ),
                  //           // ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBoxes.vert[]icalMedium,
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    child: UserTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AccountBeforeEdit()));
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const EditProfile(),
                          //   ),
                          // );
                        },
                        userName: userProvider.user!.fullName),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        String heading = '';
                        String imagePath = '';
                        double padding = 20;

                        switch (index) {
                          case 0:
                            heading = 'Change Password';
                            imagePath = PremedAssets.ChangePassword;
                            padding = 20;
                          case 1:
                            heading = 'Contact Us';
                            imagePath = PremedAssets.ContactUs;
                            padding = 20;
                          case 2: // Logout Button
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: auth.loggedInStatus ==
                                        Status.Authenticating
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                           SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                              color: Provider.of<PreMedProvider>(context,listen: false).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                                              strokeWidth: 2.0,
                                            ),
                                          ),
                                          SizedBoxes.horizontalMedium,
                                          Text(
                                            'Signing Out',
                                            style: PreMedTextTheme().subtext,
                                          ),
                                        ],
                                      )
                                    : Material(
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(8),
                                        child: CustomButton(

                                          color: isPremed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                                          buttonText: 'Sign out',
                                          onPressed: onLogoutPressed,
                                        ),
                                      ),
                              ),
                            );
                          case 3:
                            padding = 10;
                            imagePath = PremedAssets.NotificationIcon;
                            heading = 'Notifications';
                          case 4:
                            padding = 10;
                            imagePath = PremedAssets.Credits;
                            heading = 'Credits';

                          case 5:
                            heading = 'Privacy Policy';
                            imagePath = 'assets/icons/Privacy Shield Tick.png';
                            padding = 10;

                          case 6:
                            heading = 'Terms of Use';
                            imagePath = PremedAssets.Terms;
                            padding = 10;
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8500000238418579),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff26000000),
                                blurRadius: 40,
                                offset: Offset(0, 20),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: MenuTile(
                            padding: padding,
                            heading: heading,
                            icon: imagePath,
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangePassword(),
                                    ),
                                  );
                                case 1:
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const ContactUs(),
                                    ),
                                  );
                                case 3:
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationsScreen(),
                                    ),
                                  ); case 4:
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreditsScreen(),
                                    ),
                                  );
                                case 5:
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PrivacyPolicy(),
                                    ),
                                  );
                                case 6:
                                  // Handle Terms & Condition tap
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TermsCondition(),
                                    ),
                                  );
                                // case 6:
                                //   //for deletion of acc
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const DeleteAccount(),
                                //     ),
                                //   );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
