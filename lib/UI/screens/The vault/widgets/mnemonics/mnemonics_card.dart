import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/text_theme.dart';
import '../../../../../models/mnemonics_model.dart';
import '../../../../../providers/user_provider.dart';

class MnemonicsBuilderCard extends StatelessWidget {
  const MnemonicsBuilderCard({
    super.key,
    required this.mnemonicsModel,
    required this.onTap,
    required this.hasAccess,
  });

  final MnemonicsModel mnemonicsModel;
  final void Function() onTap;
  final bool hasAccess;

  @override
  Widget build(BuildContext context) {
    // Function to show the unlock dialog
    void showUnlockDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          final String appToken = userProvider.user?.info.appToken ?? '';
          return AlertDialog(
            title: Column(
              children: [
                SvgPicture.asset('assets/icons/lock.svg'),
                SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Oh No! It’s Locked',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      color: Color(0xFFFE63C49),
                    ),
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Looks like this feature is not included in your plan. Upgrade to a higher plan or purchase this feature separately to continue.',
                ),
                SizedBox(height: 10),
                Text(
                  'Visit PreMed.PK for more details.',
                ),
              ],
            ),
            actions: [
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Return',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFFFE63C49),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: !hasAccess
          ? showUnlockDialog // Show dialog if locked
          : onTap, // Execute onTap if accessible
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.85),
              border: Border.all(color: Colors.white.withOpacity(0.50)),
            ),
            height: 119,
            width: 175,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 79,
                    width: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2.5,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: mnemonicsModel.thumbnailUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(0, 20),
                              blurRadius: 20,
                            ),
                          ],
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(3.0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 66,
                            height: 21,
                            child: SvgPicture.asset(
                                'assets/images/vault/mnemonics logo.svg'),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            mnemonicsModel.topicName,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: PreMedTextTheme().heading1.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 6),
                          Flexible(
                            child: Text(
                              mnemonicsModel.subTopicName,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: PreMedTextTheme().heading1.copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.7),
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!hasAccess)
            Positioned.fill(
              child: GlassContainer(
                shadowStrength: 0,
                child: Center(
                  child: GlassContainer(
                    height: 32,
                    width: 80,
                    border: Border.all(color: Colors.white, width: 2),
                    child: Center(
                      child: Text(
                        'Unlock',
                        style: PreMedTextTheme().heading1.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15),
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
