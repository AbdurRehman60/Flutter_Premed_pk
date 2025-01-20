import 'package:installed_apps/installed_apps.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({
    super.key,
  });

  Future<void> _chooseWhatsAppApp(BuildContext context, Uri whatsAppMessenger, Uri whatsAppBusiness) async {

    final installedApps = await InstalledApps.getInstalledApps();

    final bool isWhatsAppInstalled = installedApps.any((app) => app.packageName == 'com.whatsapp');
    final bool isWhatsAppBusinessInstalled = installedApps.any((app) => app.packageName == 'com.whatsapp.w4b');

    if (isWhatsAppInstalled && isWhatsAppBusinessInstalled) {

      await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('WhatsApp Messenger'),
                onTap: () {
                  launchUrl(whatsAppMessenger);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.business),
                title: const Text('WhatsApp Business'),
                onTap: () {
                  launchUrl(whatsAppBusiness);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else if (isWhatsAppInstalled) {

      launchUrl(whatsAppMessenger);
    } else if (isWhatsAppBusinessInstalled) {

      launchUrl(whatsAppBusiness);
    } else {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Neither WhatsApp Messenger nor WhatsApp Business is installed')));
    }
  }
  @override
  Widget build(BuildContext context) {
    final PreMedProvider preMedProvider = Provider.of<PreMedProvider>(context);
    final Uri whatsAppMessenger = Uri.parse('https://wa.me/923061289229');
    final Uri whatsAppBusiness = Uri.parse('https://wa.me/923061289229');
    final Uri messenger = Uri.parse('https://m.me/PreMed.PK');
    final Uri gmail = Uri.parse('mailto:contact@premed.pk');
    final Uri hubspot = Uri.parse('https://premed.pk/about/contact');
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().background,
        leading: const PopButton(),
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
                        await _chooseWhatsAppApp(context, whatsAppMessenger, whatsAppBusiness);
                      },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: preMedProvider.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
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
                        color: preMedProvider.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
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
                          PremedAssets.Email,
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
                        color: preMedProvider.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBoxes.verticalMedium,
            // Container(
            //   decoration: BoxDecoration(
            //     color: PreMedColorTheme().white,
            //     borderRadius: BorderRadius.circular(12.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.1),
            //         spreadRadius: 1,
            //         blurRadius: 5,
            //       ),
            //     ],
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             Image.asset(
            //               PremedAssets.Chat,
            //               width: 42,
            //               height: 42,
            //             ),
            //             SizedBoxes.horizontalMedium,
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   'Live Chat',
            //                   style: PreMedTextTheme().heading6.copyWith(
            //                         color: const Color(0xFF4E5DA7),
            //                       ),
            //                 ),
            //                 Text(
            //                   'Click here to start a chat',
            //                   style: PreMedTextTheme().headline.copyWith(
            //                         fontWeight: FontWeights.medium,
            //                         color: const Color(0xFF757FB2),
            //                       ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         IconButton(
            //           onPressed: () async {
            //             launchUrl(
            //               mode: LaunchMode.inAppBrowserView,
            //               hubspot,
            //             );
            //           },
            //           icon: Icon(
            //             Icons.arrow_forward_ios_rounded,
            //             color: preMedProvider.isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
            //             size: 20,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
