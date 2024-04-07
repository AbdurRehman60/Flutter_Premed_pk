import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Uri whatsApp = Uri.parse('https://wa.me/923061289229');
    final Uri messenger = Uri.parse('https://m.me/PreMed.PK');
    final Uri gmail = Uri.parse('mailto:contact@premed.pk');
    final Uri hubspot = Uri.parse('https://premed.pk/support');
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
              'Contact Us',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(PremedAssets.ContactUS),
            SizedBoxes.verticalGargangua,
            Container(
              decoration: BoxDecoration(
                color: PreMedColorTheme().white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          PremedAssets.WhatsApp,
                          width: 42,
                          height: 42,
                        ),
                        SizedBoxes.horizontalMedium,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WhatsApp',
                              style: PreMedTextTheme().heading6.copyWith(
                                    color: const Color(0xFF009B18),
                                  ),
                            ),
                            Text(
                              'Click to start a chat',
                              style: PreMedTextTheme().headline.copyWith(
                                    fontWeight: FontWeights.medium,
                                    color: const Color(0xFF43AB53),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        launchUrl(whatsApp);
                      },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: PreMedColorTheme().primaryColorRed,
                          size: 20,
                        ),
                    )
                  ],
                ),
              ),
            ),
            SizedBoxes.verticalMedium,
            Container(
              decoration: BoxDecoration(
                color: PreMedColorTheme().white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          PremedAssets.Messenger,
                          width: 42,
                          height: 42,
                        ),
                        SizedBoxes.horizontalMedium,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Messenger',
                              style: PreMedTextTheme().heading6.copyWith(
                                    color: const Color(0xFF188DCC),
                                  ),
                            ),
                            Text(
                              'Click to start a chat',
                              style: PreMedTextTheme().headline.copyWith(
                                    fontWeight: FontWeights.medium,
                                    color: const Color(0xFF4F8BAB),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        launchUrl(messenger);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: PreMedColorTheme().primaryColorRed,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBoxes.verticalMedium,
            Container(
              decoration: BoxDecoration(
                color: PreMedColorTheme().white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          PremedAssets.Email, // Replace with Gmail icon asset
                          width: 42,
                          height: 42,
                        ),
                        SizedBoxes.horizontalMedium,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: PreMedTextTheme().heading6.copyWith(
                                    color: const Color(0xFFDA8F11),
                                  ),
                            ),
                            Text(
                              'Click to send an email',
                              style: PreMedTextTheme().headline.copyWith(
                                    fontWeight: FontWeights.medium,
                                    color: const Color(0xFFA48754),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        launchUrl(gmail);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: PreMedColorTheme().primaryColorRed,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBoxes.verticalMedium,
            Container(
              decoration: BoxDecoration(
                color: PreMedColorTheme().white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          PremedAssets.Chat, // Replace with Gmail icon asset
                          width: 42,
                          height: 42,
                        ),
                        SizedBoxes.horizontalMedium,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Live Chat',
                              style: PreMedTextTheme().heading6.copyWith(
                                    color: const Color(0xFF4E5DA7),
                                  ),
                            ),
                            Text(
                              'Click here to start a chat',
                              style: PreMedTextTheme().headline.copyWith(
                                    fontWeight: FontWeights.medium,
                                    color: const Color(0xFF757FB2),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        launchUrl(
                          mode: LaunchMode.inAppBrowserView,
                          hubspot,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: PreMedColorTheme().primaryColorRed,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
