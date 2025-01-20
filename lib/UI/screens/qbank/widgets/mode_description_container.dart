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

class ModeDescription extends StatefulWidget {
  const ModeDescription({
    super.key,
    required this.mode,
    required this.deckName,
    required this.timedTestMinutes,
    required this.subject,
    required this.premiumTag,
    required this.totalquestions,
    this.questionlist,
  });

  final List<String>? questionlist;

  final int totalquestions;
  final bool mode;
  final String deckName;
  final int timedTestMinutes;
  final String subject;
  final List<String>? premiumTag;

  @override
  State<ModeDescription> createState() => _ModeDescriptionState();
}

class _ModeDescriptionState extends State<ModeDescription> {
  @override
  Widget build(BuildContext context) {
    print("this is the premium tag :${widget
        .premiumTag} for the deck name ${widget.deckName}");
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
            if (widget.mode)
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
          Provider
              .of<PreMedProvider>(context)
              .isPreMed
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
            final userProvider = Provider.of<UserProvider>(
                context, listen: false);
            final userId = userProvider.user?.userId ?? '';

            if (userId.isNotEmpty) {
              if (_hasAccess(
                  widget.premiumTag, userProvider.getTags(), widget.mode)) {
                final attemptModel = CreateDeckAttemptModel(
                  deckName: widget.deckName,
                  attemptMode: 'tutormode',
                  user: userId,
                );
                final deckAttemptProvider = Provider.of<
                    CreateDeckAttemptProvider>(context, listen: false);
                await deckAttemptProvider.createDeckAttempt(attemptModel);

                if (deckAttemptProvider.responseMessage ==
                    'Attempt created successfully') {
                  final attemptId = deckAttemptProvider.attemptId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TutorMode(
                            isRecent: false,
                            isReview: false,
                            isContinuingAttempt: false,
                            subject: widget.subject,
                            attemptId: attemptId,
                            deckName: widget.deckName,
                            totalquestions: widget.totalquestions,
                            questionlist: widget.questionlist,
                            lastdone: '',
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
          Provider
              .of<PreMedProvider>(context)
              .isPreMed
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
            final userProvider = Provider.of<UserProvider>(
                context, listen: false);
            final userId = userProvider.user?.userId ?? '';

            if (userId.isNotEmpty) {
              // Check access for Timed Test Mode
              if (_hasAccess(
                  widget.premiumTag, userProvider.getTags(), false)) {
                final attemptModel = CreateDeckAttemptModel(
                  deckName: widget.deckName,
                  attemptMode: 'testmode',
                  user: userId,
                );
                final deckAttemptProvider = Provider.of<
                    CreateDeckAttemptProvider>(context, listen: false);
                await deckAttemptProvider.createDeckAttempt(attemptModel);

                if (deckAttemptProvider.responseMessage ==
                    'Attempt created successfully') {
                  final attemptId = deckAttemptProvider.attemptId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TestInterface(
                            isReview: false,
                            isRecent: false,
                            isContinuingAttempt: false,
                            subject: widget.subject,
                            attemptId: attemptId,
                            deckName: widget.deckName,
                            totalquestions: widget.totalquestions,
                            questionlist: widget.questionlist,
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

  bool _hasAccess(List<String>? premiumTags, Object? accessTags, bool? isTutorModeFree) {
    if (isTutorModeFree == true || premiumTags == null || premiumTags.isEmpty) {
      return true;
    }

    final List<String> mdcatTags = ['MDCAT-Topicals', 'MDCAT-Yearly'];
    final List<String> numsTags = ['NUMS-Topicals', 'NUMS-Yearly'];
    final List<String> privTags = ['AKU-Topicals', 'AKU-Yearly'];

    // Ensure accessTags is a list of dynamic objects
    if (accessTags is List<dynamic>) {
      for (final premiumTag in premiumTags) {
        final bool foundMatch = false; // Flag to track if a match was found

        for (final access in accessTags) {
          if (access is Map<String, dynamic>) {
            // Direct match
            if (access['name'] == premiumTag) {
              print(
                  'Match found: premiumTag "$premiumTag" matches with accessTag "${access['name']}"');
              return true;
            }

            // Group match for predefined tags
            if ((premiumTag == 'MDCAT-QBank' &&
                mdcatTags.contains(access['name'])) ||
                (premiumTag == 'NUMS-QBank' &&
                    numsTags.contains(access['name'])) ||
                (premiumTag == 'AKU-QBank' &&
                    privTags.contains(access['name']))) {
              print(
                  'Match found: premiumTag "$premiumTag" matches with group tag "${access['name']}"');
              return true;
            }
          }
        }

        // If no match was found for the current premiumTag
        if (!foundMatch) {
          print('No match found for premiumTag "$premiumTag" in accessTags.');
        }
      }
    }

    // Access denied if no match is found
    print('Access denied: No matches found for premiumTags.');
    return false;
  }
}
void _showPurchasePopup(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final String appToken = userProvider.user?.info.appToken ?? '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
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
