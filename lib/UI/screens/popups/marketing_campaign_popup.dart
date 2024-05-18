import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/timer.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketingCampaignPopup extends StatelessWidget {
  const MarketingCampaignPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().primaryColorRedLighter,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: PreMedColorTheme().primaryColorRed,
              size: 34,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainNavigationScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: PreMedTextTheme().subtext.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 36,
                    color: PreMedColorTheme().black),
                children: [
                  TextSpan(
                    text: 'Pre',
                    style: PreMedTextTheme().subtext1.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  TextSpan(
                    text: 'M',
                    style: PreMedTextTheme().subtext1.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  TextSpan(
                    text: 'ed:',
                    style: PreMedTextTheme().subtext1.copyWith(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const TextSpan(
                    text: ' Now',
                  ),
                ],
              ),
            ),
            SizedBoxes.verticalMedium,
            Text('100% Free',
                style: PreMedTextTheme().body.copyWith(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: PreMedColorTheme().primaryColorRed)),
            SizedBoxes.verticalMedium,
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: PreMedTextTheme().subtext.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Colors.blueAccent),
                      children: [
                        const TextSpan(text: 'Notes'),
                        TextSpan(
                          text: ', ',
                          style: PreMedTextTheme().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: PreMedColorTheme().black),
                        ),
                        const TextSpan(text: 'QBank'),
                        TextSpan(
                          text: ', ',
                          style: PreMedTextTheme().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: PreMedColorTheme().black),
                        ),
                        const TextSpan(text: 'Mocks '),
                        TextSpan(
                          text: 'and ',
                          style: PreMedTextTheme().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: PreMedColorTheme().black),
                        ),
                        const TextSpan(text: 'Guidance videos'),
                        TextSpan(
                          text: '!',
                          style: PreMedTextTheme().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: PreMedColorTheme().black),
                        )
                      ])),
            ),
            SizedBoxes.verticalMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      launchUrl(
                        mode: LaunchMode.inAppBrowserView,
                        Uri.parse("https://premed.pk/auth/login"),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PreMedColorTheme().primaryColorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: PreMedColorTheme().primaryColorRed200,
                            width: 2),
                      ),
                    ),
                    child: Text(
                      'Avail Free Trial',
                      style: PreMedTextTheme().body.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: PreMedColorTheme().white,
                          ),
                    ),
                  ),
                ),
                SizedBoxes.horizontal15Px,
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      launchUrl(
                        mode: LaunchMode.inAppBrowserView,
                        Uri.parse("https://premed.pk/pricing/all"),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PreMedColorTheme().white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: PreMedColorTheme().white, width: 2),
                      ),
                    ),
                    child: Text(
                      'Avail 70% Off',
                      textAlign: TextAlign.center,
                      style: PreMedTextTheme().body.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: PreMedColorTheme().primaryColorRed,

                          ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBoxes.verticalExtraGargangua,
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: PreMedTextTheme().subtext.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.blueAccent),
                    children: [
                      const TextSpan(text: 'The '),
                      TextSpan(
                          text: 'Free Trial ',
                          style: PreMedTextTheme().body.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Colors.blueAccent)),
                      const TextSpan(text: 'Ends In')
                    ])),
            SizedBoxes.verticalMedium,
            const TimerWidget(),
            SizedBoxes.verticalExtraGargangua,
            SizedBoxes.verticalExtraGargangua,
            Container(
              width: double.infinity,
              height: 30,
              color: PreMedColorTheme().customCheckboxColor,
              child: Center(
                  child: Text(
                'LIMITED TIME ONLY',
                textAlign: TextAlign.center,
                style: PreMedTextTheme().body.copyWith(
                    color: PreMedColorTheme().tickcolor,
                    fontWeight: FontWeight.w900,
                    fontSize: 20),
              )),
            ),
            SizedBoxes.verticalExtraGargangua,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'PreMed is offering many of its features for free from 19th May till 25th May. Terms and Conditions Apply.',
                textAlign: TextAlign.center,
                style: PreMedTextTheme()
                    .body
                    .copyWith(color: PreMedColorTheme().neutral500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
