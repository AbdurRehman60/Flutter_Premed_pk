import 'package:premedpk_mobile_app/UI/Widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/user_provider.dart';
import '../../Widgets/or_divider.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({super.key});

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  Future<void> _launchURL(String appToken) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String lastonboarding = userProvider.user!.info.lastOnboardingPage;

    String bundlePath;
    if (lastonboarding.contains("pre-medical")) {
      bundlePath = "/bundles/mdcat";
    } else {
      bundlePath = "/bundles/all-in-one";
    }

    final url = 'https://premed.pk/app-redirect?url=$appToken&&route=$bundlePath';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String appToken = userProvider.user?.info.appToken ?? '';

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              PremedAssets.Celebration,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  PremedAssets.Purchase,
                  width: 132,
                  height: 132,
                  fit: BoxFit.fill,
                ),
                GradientText(
                  'Thank You!',
                  style: PreMedTextTheme().heading1.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  colors: [
                    PreMedColorTheme().primaryColorBlue,
                    PreMedColorTheme().primaryColorRed
                  ],
                ),
                SizedBoxes.verticalTiny,
                Text(
                  'You will now be redirected to the web',
                  style: PreMedTextTheme().body.copyWith(
                    color: PreMedColorTheme().neutral600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: CustomButton(
                      buttonText: 'Avail New User Discount',
                      onPressed: () {
                        _launchURL(appToken);
                      },
                    ),
                  ),

                  SizedBoxes.verticalMicro,
                  const Padding(
                    padding:  EdgeInsets.only(left: 36,right: 36),
                    child: OrDivider(),
                  ),
                  SizedBoxes.verticalMicro,

                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: CustomButton(
                      buttonText: 'Explore App First',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainNavigationScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
