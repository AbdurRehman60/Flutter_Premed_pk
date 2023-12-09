import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri whatsApp = Uri.parse('https://wa.me/923061289229');
    final Uri messenger = Uri.parse('https://m.me/PreMed.PK');
    final Uri gmail = Uri.parse('mailto:contact@premed.pk');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        title: Text(
          'Contact Us',
          style: PreMedTextTheme().heading7.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: PreMedColorTheme().black,
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
                color: const Color(0xFFDDFFE2),
                borderRadius: BorderRadius.circular(8.0),
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
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('WhatsApp'),
                            Text('Click to start a chat'),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        launchUrl(whatsApp);
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBoxes.verticalMedium,
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEBF7FF),
                borderRadius: BorderRadius.circular(8.0),
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
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Messenger'),
                            Text('Click to start a chat'),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        launchUrl(messenger);
                      },
                      icon: CircleAvatar(
                        backgroundColor: const Color(0xFF039DFD),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBoxes.verticalMedium,
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFEFD5),
                borderRadius: BorderRadius.circular(8.0),
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
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gmail'),
                            Text('Click to send an email'),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        launchUrl(gmail);
                      },
                      icon: CircleAvatar(
                        backgroundColor: const Color(0xFFFBA028),
                        child: Icon(
                          Icons.arrow_forward,
                          color: PreMedColorTheme().white,
                        ),
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
