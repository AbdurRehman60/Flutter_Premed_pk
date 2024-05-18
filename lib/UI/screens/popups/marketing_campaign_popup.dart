import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/timer.dart';
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: PreMedColorTheme().primaryColorRed,
              size: 34,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/market-logo.png',
              ),
              fit: BoxFit.fitWidth),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: PreMedTextThemeRubik().subtext.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 45,
                    color: PreMedColorTheme().black),
                children: [
                  TextSpan(
                    text: 'Pre',
                    style: PreMedTextThemeRubik().subtext1.copyWith(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  TextSpan(
                    text: 'M',
                    style: PreMedTextThemeRubik().subtext1.copyWith(
                          color: PreMedColorTheme().primaryColorRed,
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  TextSpan(
                    text: 'ed:',
                    style: PreMedTextThemeRubik().subtext1.copyWith(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const TextSpan(
                    text: ' Now',
                  ),
                ],
              ),
            ),
            Text(
              '100% Free',
              style: PreMedTextThemeRubik().body.copyWith(
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  color: PreMedColorTheme().primaryColorRed,
                  height: 1.5),
            ),
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: PreMedTextThemeRubik().subtext.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          height: 1.5,
                          color: Colors.blueAccent),
                      children: [
                        const TextSpan(text: 'Notes'),
                        TextSpan(
                          text: ', ',
                          style: PreMedTextThemeRubik().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              height: 1.5,
                              color: PreMedColorTheme().black),
                        ),
                        const TextSpan(text: 'QBank'),
                        TextSpan(
                          text: ', ',
                          style: PreMedTextThemeRubik().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              height: 1.5,
                              color: PreMedColorTheme().black),
                        ),
                        const TextSpan(text: 'Mocks '),
                        TextSpan(
                          text: 'and ',
                          style: PreMedTextThemeRubik().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              height: 1.5,
                              color: PreMedColorTheme().black),
                        ),
                        const TextSpan(text: 'Guidance videos'),
                        TextSpan(
                          text: '!',
                          style: PreMedTextThemeRubik().subtext1.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 25,
                              height: 1.5,
                              color: PreMedColorTheme().black),
                        )
                      ])),
            ),
            SizedBoxes.vertical26Px,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 160,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PreMedColorTheme().primaryColorRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: PreMedColorTheme().primaryColorRed200,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      'Avail Free Trial',
                      style: PreMedTextThemeRubik().body.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
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
                      'Avail 50% Off',
                      style: PreMedTextThemeRubik().body.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
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
                    style: PreMedTextThemeRubik().subtext.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.blueAccent),
                    children: [
                      const TextSpan(text: 'The '),
                      TextSpan(
                          text: 'Free Trial ',
                          style: PreMedTextThemeRubik().body.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blueAccent)),
                      const TextSpan(text: 'Ends In')
                    ])),
            SizedBoxes.verticalMedium,
            const TimerWidget(),
            SizedBoxes.verticalExtraGargangua,
            Container(
              width: double.infinity,
              height: 30,
              color: PreMedColorTheme().customCheckboxColor,
              child: Center(
                  child: Text(
                'LIMITED TIME ONLY',
                textAlign: TextAlign.center,
                style: PreMedTextThemeRubik().body.copyWith(
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
                style: PreMedTextThemeRubik()
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
