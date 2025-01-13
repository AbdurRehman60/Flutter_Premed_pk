import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart'; // Assuming this contains your text theme constants
import 'package:premedpk_mobile_app/models/mnemonics_model.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_access_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../providers/user_provider.dart'; // Required for _launchURL

class MnemonicsCard extends StatelessWidget {
  const MnemonicsCard({
    super.key,
    required this.mnemonics,
    required this.onPlay,
  });

  final MnemonicsModel mnemonics;
  final void Function() onPlay;

  @override
  Widget build(BuildContext context) {
    // Function to show the unlock dialog
    void showUnlockDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final userProvider = Provider.of<PreMedAccessProvider>(
              context,
              listen: false);
          final userProviderr = Provider.of<UserProvider>(context, listen: false);

          final String appToken = userProviderr.user?.info.appToken ?? '';
          return AlertDialog(
            title: const Text('Purchase Plan'),
            content: const Text(
                'You need to purchase the Ultimate plan to access this mnemonic.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _launchURL(appToken);
                },
                child: const Text('Purchase'),
              ),
            ],
          );
        },
      );
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 10),
          )
        ],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 3),
      ),
      height: 150,
      width: 102,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                    child: CachedNetworkImage(
                      imageUrl: mnemonics.thumbnailUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(3.0)),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                final hasAccess = Provider.of<PreMedAccessProvider>(
                                    context,
                                    listen: false)
                                    .hasMnemonics;
                                if (hasAccess) {
                                  onPlay();
                                } else {
                                  showUnlockDialog();
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF18204F).withOpacity(0.4),
                                      const Color(0xFF18204F).withOpacity(0.25),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 2.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      offset: const Offset(0, 20),
                                      blurRadius: 40,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (!Provider.of<PreMedAccessProvider>(context).hasMnemonics)
            Positioned.fill(
              child: GlassContainer(
                child: Center(
                  child: GlassContainer(
                    border: Border.all(color: Colors.white, width: 2),
                    height: 32,
                    width: 80,
                    child: Center(
                      child: Text(
                        'Unlock',
                        style: PreMedTextTheme().heading1.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Utility function to launch URL
Future<void> _launchURL(String appToken) async {
  final Uri url = Uri.parse('https://www.premed.pk/?token=$appToken');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
