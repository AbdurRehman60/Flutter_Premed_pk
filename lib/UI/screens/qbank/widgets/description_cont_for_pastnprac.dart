import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/widgets/tutor_mode_test_interface.dart';
import 'package:premedpk_mobile_app/constants/assets.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/color_theme.dart';
import '../../../../constants/sized_boxes.dart';
import '../../../../constants/text_theme.dart';
import '../../../../models/create_deck_attemot_model.dart';
import '../../../../providers/create_deck_attempt_provider.dart';
import '../../../../providers/user_provider.dart';
import '../../../Widgets/global_widgets/custom_button.dart';

class DescriptionContForPastnprac extends StatefulWidget {
  const DescriptionContForPastnprac({
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
  final String? premiumTag;

  @override
  State<DescriptionContForPastnprac> createState() => _DescriptionContForPastnpracState();
}

class _DescriptionContForPastnpracState extends State<DescriptionContForPastnprac> {
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
            _buildMode(context, pro),
          ],
        ),
      ),
    );
  }


  Widget _buildMode(BuildContext context, PreMedProvider pro) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final bool hasFullAccess = _hasAccess(widget.premiumTag, userProvider.getTags(), widget.mode);

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
            widget.mode ? 'Past Paper' : 'Practice',
            style: PreMedTextTheme().heading2.copyWith(
                color: pro.isPreMed
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().blue,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
        SizedBoxes.verticalTiny,
        DescriptionText(
          descriptionText: widget.mode
              ? 'This paper is NOT timed'
              : 'Paper will be timed according to the original time given for the paper.',
        ),
        SizedBoxes.verticalTiny,
        DescriptionText(
          descriptionText: widget.mode
              ? 'The Correct answer and explanation will be shown instantly once you select any option'
              : 'Scored Report will be shown once you press the ‘Finish’ button.',
        ),
        SizedBoxes.verticalTiny,
        DescriptionText(
          descriptionText: widget.mode
              ? "Timer and detailed score report are not available in 'Past Paper' and can be accessed in 'Practice'"
              : "Correct answers and detailed explanations will be shown once you press the ‘Finish’ button.",
        ),
        SizedBoxes.verticalMedium,


        CustomButton(
          color: pro.isPreMed
              ? PreMedColorTheme().red
              : PreMedColorTheme().blue,
          buttonText: 'Start Test',
          onPressed: () {
            if (hasFullAccess) {
              _startTest(context);
            } else {
              _showPurchasePopup(context);
            }
          },
        ),
        SizedBoxes.verticalTiny,
        const Center(child: Text("or")),

        CustomButton(
          color: pro.isPreMed
              ? PreMedColorTheme().red
              : PreMedColorTheme().blue,
          buttonText: 'Attempt 5 Questions for Free',
          onPressed: () async {
            await _attempt5Questions(context);
          },
        ),
        SizedBoxes.verticalMedium,
      ],
    );
  }


  void _startTest(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.userId ?? '';

    if (userId.isNotEmpty) {
      final attemptModel = CreateDeckAttemptModel(
        deckName: widget.deckName,
        attemptMode: widget.mode ? 'tutormode' : 'testmode',
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
              isRecent: false,
              isReview: false,
              isContinuingAttempt: false,
              subject: widget.subject,
              attemptId: attemptId,
              deckName: widget.deckName,
              totalquestions: widget.totalquestions,
              questionlist: widget.questionlist,
              buttontext: 'Start Test',
              lastdone: '',
            ),
          ),
        );
      } else {
        _showErrorPopup(context, deckAttemptProvider.responseMessage);
      }
    }
  }

  Future<void> _attempt5Questions(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.userId ?? '';

    if (userId.isNotEmpty) {
      final attemptModel = CreateDeckAttemptModel(
        deckName: widget.deckName,
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
              subject: widget.subject,
              attemptId: attemptId,
              deckName: widget.deckName,
              totalquestions: widget.totalquestions,
              questionlist: widget.questionlist,
              buttontext: 'Attempt 5 Questions for Free',
              lastdone: '',
            ),
          ),
        );
      } else {
        _showErrorPopup(context, deckAttemptProvider.responseMessage);
      }
    }
  }


  void _showPurchasePopup(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String appToken = userProvider.user?.info.appToken?? '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Purchase Required"),
          content: const Text("Your current plan does not have access to this paper. Purchase our Plan to access this feature!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Go Back"),
            ),
            TextButton(
              onPressed: () {
                _launchURL(appToken);
              },
              child: const Text("Purchase Plan"),
            ),
          ],
        );
      },
    );
  }

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

  bool _hasAccess(String? premiumTag, Object? accessTags, bool? isPastPaperFree) {
    if (isPastPaperFree == true || premiumTag == null || premiumTag.isEmpty) {
      return true;
    }

    final List<String> mdcatTags = ['MDCAT-Topicals', 'MDCAT-Yearly'];
    final List<String> numsTags = ['NUMS-Topicals', 'NUMS-Yearly'];
    final List<String> privTags = ['AKU-Topicals', 'AKU-Yearly'];

    if (accessTags is List<dynamic>) {
      for (final access in accessTags) {
        if (access is Map<String, dynamic>) {
          if (access['name'] == premiumTag) {
            return true;
          }
          if ((premiumTag == 'MDCAT-QBank' && mdcatTags.contains(access['name'])) ||
              (premiumTag == 'NUMS-QBank' && numsTags.contains(access['name'])) ||
              (premiumTag == 'AKU-QBank' && privTags.contains(access['name']))) {
            return true;
          }
        }
      }
    }

    return false;
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
