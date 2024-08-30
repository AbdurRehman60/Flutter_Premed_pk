import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/widgets/tutor_mode_test_interface.dart';
import 'package:premedpk_mobile_app/constants/assets.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/color_theme.dart';
import '../../../../constants/sized_boxes.dart';
import '../../../../constants/text_theme.dart';
import '../../../../models/create_deck_attemot_model.dart';
import '../../../../providers/create_deck_attempt_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../Widgets/global_widgets/custom_button.dart';
import '../../Test Interface/test_interface_home.dart';

class ModeDescription extends StatelessWidget {
  const ModeDescription({
    super.key,
    required this.mode,
    required this.deckName,
    required this.timedTestMinutes,
    required this.subject,
    required this.premiumTag, // New addition to pass premiumTag
  });

  final bool mode;
  final String deckName;
  final int timedTestMinutes;
  final String subject;
  final String? premiumTag; // New field for premiumTag

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<PreMedProvider>(context);
    return Material(
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        color: const Color(0xFFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxes.verticalTiny,
            if (mode)
              _buildTutorMode(context, pro)
            else
              _buildTimedTestMode(context, pro),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorMode(BuildContext context, PreMedProvider pro) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          height: 45,
          Provider.of<PreMedProvider>(context).isPreMed
              ? PremedAssets.RedDocument
              : PremedAssets.BlueDocument,
        ),
        SizedBoxes.verticalTiny,
        Center(
          child: Text(
            'Tutor Mode',
            style: PreMedTextTheme().heading2.copyWith(
                color: pro.isPreMed
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().blue,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
        SizedBoxes.verticalTiny,
        const DescriptionText(
          descriptionText: 'This paper is NOT timed',
        ),
        SizedBoxes.verticalTiny,
        const DescriptionText(
          descriptionText:
          'The Correct answer and explanation will be shown instantly once you select any option',
        ),
        SizedBoxes.verticalTiny,
        const DescriptionText(
          descriptionText:
          "Timer and detailed score report are not available in 'Tutor Mode' and can be accessed in 'Time Test Mode'",
        ),
        SizedBoxes.verticalMedium,
        CustomButton(
          color: pro.isPreMed
              ? PreMedColorTheme().red
              : PreMedColorTheme().blue,
          buttonText: 'Start Test',
          onPressed: () async {
            final userProvider = Provider.of<UserProvider>(context, listen: false);
            final userId = userProvider.user?.userId ?? '';

            if (userId.isNotEmpty) {
              // Check access for Tutor Mode
              if (_hasAccess(premiumTag, userProvider.getTags(), mode)) {
                final attemptModel = CreateDeckAttemptModel(
                  deckName: deckName,
                  attemptMode: 'tutormode',
                  user: userId,
                );
                final deckAttemptProvider = Provider.of<CreateDeckAttemptProvider>(context, listen: false);
                await deckAttemptProvider.createDeckAttempt(attemptModel);

                if (deckAttemptProvider.responseMessage == 'Attempt created successfully') {
                  final attemptId = deckAttemptProvider.attemptId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TutorMode(
                        isContinuingAttempt: false,
                        subject: subject,
                        attemptId: attemptId,
                        deckName: deckName,
                      ),
                    ),
                  );
                } else {
                  _showErrorPopup(context, deckAttemptProvider.responseMessage);
                }
              } else {
                _showPurchasePopup(context);
              }
            }
          },
        ),
        SizedBoxes.verticalMedium,
      ],
    );
  }

  Widget _buildTimedTestMode(BuildContext context, PreMedProvider pro) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          height: 45,
          Provider.of<PreMedProvider>(context).isPreMed
              ? PremedAssets.RedDocument
              : PremedAssets.BlueDocument,
        ),
        SizedBoxes.verticalTiny,
        Center(
          child: Text(
            'Timed Test Mode',
            style: PreMedTextTheme().heading2.copyWith(
                color: pro.isPreMed
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().blue,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
        SizedBoxes.verticalTiny,
        const DescriptionText(
          descriptionText:
          'Paper will be timed according to the original time given for the paper.',
        ),
        SizedBoxes.verticalTiny,
        const DescriptionText(
          descriptionText:
          'Scored Report will be shown once you press the ‘Finish’ button.',
        ),
        SizedBoxes.verticalTiny,
        const DescriptionText(
          descriptionText:
          "Correct answers and detailed explanations will be shown once you press the ‘Finish’ button.",
        ),
        SizedBoxes.verticalMedium,
        CustomButton(
          buttonText: 'Start Test',
          color: pro.isPreMed
              ? PreMedColorTheme().primaryColorRed
              : PreMedColorTheme().blue,
          onPressed: () async {
            final userProvider = Provider.of<UserProvider>(context, listen: false);
            final userId = userProvider.user?.userId ?? '';

            if (userId.isNotEmpty) {
              // Check access for Timed Test Mode
              if (_hasAccess(premiumTag, userProvider.getTags(), false)) {
                final attemptModel = CreateDeckAttemptModel(
                  deckName: deckName,
                  attemptMode: 'testmode',
                  user: userId,
                );
                final deckAttemptProvider = Provider.of<CreateDeckAttemptProvider>(context, listen: false);
                await deckAttemptProvider.createDeckAttempt(attemptModel);

                if (deckAttemptProvider.responseMessage == 'Attempt created successfully') {
                  final attemptId = deckAttemptProvider.attemptId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestInterface(
                        isContinuingAttempt: false,
                        subject: subject,
                        attemptId: attemptId,
                        deckName: deckName,
                      ),
                    ),
                  );
                } else {
                  _showErrorPopup(context, deckAttemptProvider.responseMessage);
                }
              } else {
                _showPurchasePopup(context);
              }
            }
          },
        ),
        SizedBoxes.verticalMedium,
      ],
    );
  }

  bool _hasAccess(String? premiumTag, Object? accessTags, bool? isTutorModeFree) {
    if (isTutorModeFree == true || premiumTag == null || premiumTag.isEmpty) {
      return true;
    }

    final List<String> mdcatTags = ['MDCAT-Topicals', 'MDCAT-Yearly'];
    final List<String> numsTags = ['NUMS-Topicals', 'NUMS-Yearly'];
    final List<String> privTags = ['AKU-Topicals', 'AKU-Yearly'];

    if (accessTags is List<dynamic>) {
      for (final access in accessTags) {
        if (access is Map<String, dynamic>) {
          print('Comparing premiumTag: $premiumTag with access name: ${access['name']}');

          if (access['name'] == premiumTag) {
            return true;
          }
          if ((premiumTag == 'MDCAT-QBank' && mdcatTags.contains(access['name'])) ||
              (premiumTag == 'NUMS-QBank' && numsTags.contains(access['name'])) ||
              (premiumTag == 'AKU-QBank' && privTags.contains(access['name']))) {
            print('Match found: Yes');
            return true;
          }
        }
      }
    }

    print('Match found: No');
    return false;
  }

  void _showPurchasePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Purchase Required"),
          content: const Text("You need to purchase the required bundle to access this content."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorPopup(BuildContext context, String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message ?? 'Unknown error occurred'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key, required this.descriptionText});
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('\u2022'),
        SizedBoxes.horizontalTiny,
        Expanded(
          child: Text(
            descriptionText,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.normal,
              height: 1.3,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
