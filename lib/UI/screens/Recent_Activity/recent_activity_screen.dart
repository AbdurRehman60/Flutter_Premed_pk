import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:premedpk_mobile_app/UI/screens/Recent_Activity/widgets/recent_activity.dart';
import 'package:premedpk_mobile_app/UI/screens/Test%20Interface/widgets/tutor_mode_test_interface.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/recent_attempts_model.dart';
import 'package:premedpk_mobile_app/providers/question_provider.dart';
import 'package:premedpk_mobile_app/providers/recent_atempts_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/vaultProviders/premed_provider.dart';
import '../Test Interface/test_interface_home.dart';
import '../The vault/widgets/back_button.dart';
class RecentActivityScreen extends StatefulWidget {
  const RecentActivityScreen({super.key, required this.isPreMed});
  final bool isPreMed;

  @override
  State<RecentActivityScreen> createState() => _RecentActivityScreenState();
}

class _RecentActivityScreenState extends State<RecentActivityScreen> {
  bool isContinuingAttempt = false;

  Future<void> _resumeAttempt(BuildContext context, RecentAttempt recentAttempt,
      {int startFromQuestion = 0, String? attemptId}) async {
    final questionProvider =
    Provider.of<QuestionProvider>(context, listen: false);
    final deckName = recentAttempt.deckName;
    print('resume Called');
    if (deckName == null) {
      print('Error: Deck name is null');
      return;
    }

    await questionProvider.fetchQuestions(deckName, 1);

    if (!mounted) {
      return;
    }

    final startFrom = startFromQuestion >= 0 ? startFromQuestion : 0;
    final attemptIdValue = attemptId ?? recentAttempt.attempts?.id;

    if (attemptIdValue != null) {
      if (recentAttempt.mode == 'TESTMODE') {
        _navigateToTestInterface(
          deckName,
          startFromQuestion: startFrom,
          attemptId: attemptIdValue,
          subject: recentAttempt.attempts?.attempts?.last.subject ?? '',
        );
      } else {
        _navigateToTutorInterface(deckName,
            startFromQuestion: startFrom,
            attemptId: attemptIdValue,
            subject: recentAttempt.attempts?.attempts?.last.subject ?? '');
      }
    } else {
      print('Error: Attempt ID is null');
    }
    }

  Future<void> _restartAttempt(
      BuildContext context, RecentAttempt recentAttempt) async {
    setState(() {
      isContinuingAttempt = false;
    });
    final questionProvider =
    Provider.of<QuestionProvider>(context, listen: false);
    await questionProvider.fetchQuestions(recentAttempt.deckName!, 1);

    if (recentAttempt.mode == 'TESTMODE') {
      _navigateToTestInterface(
        recentAttempt.deckName!,
        attemptId: 'no ID',
        subject: recentAttempt.attempts?.attempts?.first.subject ?? '',
      );
    } else {
      _navigateToTutorInterface(
        recentAttempt.deckName!,
        attemptId: 'no ID',
        subject: recentAttempt.attempts?.attempts?.first.subject ?? '',
      );
    }
  }
  void _navigateToTestInterface(
      String deckName, {
        required String attemptId,
        String? subject,
        int startFromQuestion = 0,
      }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TestInterface(
          deckName: deckName,
          attemptId: attemptId,
          subject: subject ?? '',
          startFromQuestion: startFromQuestion,
          isContinuingAttempt: isContinuingAttempt,
        ),
      ),
    );
  }

  void _navigateToTutorInterface(
      String deckName, {
        required String attemptId,
        String? subject,
        int startFromQuestion = 0,
      }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TutorMode(
          deckName: deckName,
          attemptId: attemptId,
          subject: subject ?? '',
          startFromQuestion: startFromQuestion,
          isContinuingAttempt: isContinuingAttempt,
        ),
      ),
    );
  }

  void _showResumeOrRestartOptions(
      BuildContext context, RecentAttempt recentAttempt) {
    final double progressValue = _calculateProgress(recentAttempt);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BottomSheetWidget(
          progressValue: progressValue,
          activityName: recentAttempt.deckName,
          date: recentAttempt.attemptedDate.toString(),
          mode: recentAttempt.mode,
          resume: () {
            setState(() {
              isContinuingAttempt = true;
            });
            Navigator.pop(context);
            _resumeAttempt(context, recentAttempt);
          },
          restart: () {
            setState(() {
              isContinuingAttempt = false;
            });
            Navigator.pop(context);
            _restartAttempt(context, recentAttempt);
          },
        );
      },
    );
  }

  double _calculateProgress(RecentAttempt attempt) {
    if (attempt.totalQuestions != null && attempt.totalQuestions! > 0) {
      return attempt.totalAttempts! / attempt.totalQuestions!.toDouble();
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: const PopButton(),
          ),
        ),
      ),
      body: Consumer<RecentAttemptsProvider>(
        builder: (context, provider, child) {
          if (provider.recentAttempts.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: widget.isPreMed
                    ? PreMedColorTheme().red
                    : PreMedColorTheme().blue,
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Activity',
                      style: PreMedTextTheme()
                          .heading4
                          .copyWith(fontWeight: FontWeight.w800, fontSize: 28),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'Your recent activity, on the website and the app.',
                      style: PreMedTextTheme().body.copyWith(fontSize: 17),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.recentAttempts.length,
                  itemBuilder: (context, index) {
                    final RecentAttempt recentAttempt =
                    provider.recentAttempts[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      child: RecentActivityCard1(
                        isPreMed: widget.isPreMed,
                        onTap: () =>
                            _showResumeOrRestartOptions(context, recentAttempt),
                        acivityname: recentAttempt.deckName,
                        date: recentAttempt.attemptedDate.toString(),
                        progressValue: _calculateProgress(recentAttempt),
                        mode: recentAttempt.mode,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
    this.progressValue,
    this.activityName,
    this.date,
    this.mode,
    this.onTap,
    required this.restart,
    required this.resume,
  });
  final double? progressValue;
  final String? activityName;
  final String? date;
  final String? mode;
  final VoidCallback? onTap;
  final VoidCallback restart;
  final VoidCallback resume;

  @override
  State<StatefulWidget> createState() {
    return _BottomSheetWidgetState();
  }
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final String formattedDate = widget.date != null
        ? DateFormat('d MMMM yyyy').format(DateTime.parse(widget.date!))
        : '';
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
        height: screenHeight * 0.4,
        width: screenWidth,
        decoration: BoxDecoration(
          color: PreMedColorTheme().white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 60,
                    ),
                    child: Text(
                      widget.activityName ?? '',
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        Provider.of<PreMedProvider>(context).isPreMed
                            ? PremedAssets.RedDocument
                            : PremedAssets.BlueDocument,
                        height: 50,
                        width: 50,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: LinearProgressIndicator(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                            backgroundColor: Colors.grey[300],
                            value: widget.progressValue?.clamp(0.0, 1.0),
                            valueColor: AlwaysStoppedAnimation(
                                _getColor(widget.progressValue ?? 0.0)),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          '${(widget.progressValue! * 100).toInt()}% Complete',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formattedDate,
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Text(widget.mode ?? '',
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  color: Provider.of<PreMedProvider>(context)
                                      .isPreMed
                                      ? PreMedColorTheme().red
                                      : PreMedColorTheme().blue)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBoxes.horizontalExtraGargangua,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Provider.of<PreMedProvider>(context).isPreMed
                            ? PreMedColorTheme().red
                            : PreMedColorTheme().blue,
                        elevation: 10,
                      ), // Set the color to red
                      onPressed: widget.resume,
                      child: Text(
                        'Resume Test',
                        style: GoogleFonts.rubik(
                          color: PreMedColorTheme().white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBoxes.verticalBig,
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                      ),
                      onPressed: widget.restart,
                      child: Text(
                        'Restart',
                        style: GoogleFonts.rubik(
                          color: Provider.of<PreMedProvider>(context).isPreMed
                              ? PreMedColorTheme().red
                              : PreMedColorTheme().blue,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Color _getColor(double progressValue) {
    if (progressValue < 0.3) {
      return Provider.of<PreMedProvider>(context).isPreMed
          ? PreMedColorTheme().red
          : PreMedColorTheme().coolBlue;
    } else if (progressValue < 0.6) {
      return Provider.of<PreMedProvider>(context).isPreMed
          ? PreMedColorTheme().red
          : PreMedColorTheme().coolBlue;
    } else {
      return Colors.green;
    }
  }
}
