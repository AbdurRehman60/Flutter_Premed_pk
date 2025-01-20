import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/recent_activity_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/lastest_attempts_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';

import '../dashboard_screen.dart';

class LatestAttemptScreen extends StatefulWidget {
  const LatestAttemptScreen({super.key, required this.isPreMed});
  final bool isPreMed;

  @override
  State<StatefulWidget> createState() {
    return _LatestAttemptScreenState();
  }
}
//1
class _LatestAttemptScreenState extends State<LatestAttemptScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LatestAttemptPro>(context, listen: false)
          .fetchLatestAttempt(context);
    });
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    return DateFormat('d MMMM yyyy, h:mm a').format(now); // Format as desired
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LatestAttemptPro>(
      builder: (context, latestAttemptProvider, _) {
        switch (latestAttemptProvider.status) {
          case FetchAttemptStatus.init:
          case FetchAttemptStatus.fetching:
            return const DummyStatContainer();
          case FetchAttemptStatus.success:
            final latestAttempt = latestAttemptProvider.latestAttempt;
            if (latestAttempt != null && latestAttempt.results.isNotEmpty) {
              return RecentActivityCard(
                isPreMed: widget.isPreMed,
                acivityname: latestAttempt.results.first.deckName,
                date: latestAttempt.results.first.createdAt,
                progressValue: latestAttempt.results.first.totalAttempts /
                    latestAttempt.results.first.totalQuestions,
                mode: latestAttempt.results.first.attemptMode,
              );
            } else {
              return const DummyStatContainer();
            }
          case FetchAttemptStatus.error:
            return const DummyStatContainer();
        }
      },
    );
  }

}

class DummyStatContainer extends StatelessWidget {
  const DummyStatContainer({super.key});

  @override
  Widget build(BuildContext context) {
    String getCurrentDateTime() {
      final DateTime now = DateTime.now();
      return DateFormat('d MMMM yyyy').format(now); // Format as desired
    }

    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: PreMedColorTheme().white85,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: CustomBoxShadow.boxShadow40),
        child: Padding(
          padding: const EdgeInsets.only(left: 14, top: 10, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Recent Activity',
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: const Color.fromARGB(255, 74, 74, 74))),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: Provider.of<PreMedProvider>(context).isPreMed
                              ? PreMedColorTheme().red
                              : PreMedColorTheme().blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50, right: 10),
                    child: SvgPicture.asset(
                      Provider.of<PreMedProvider>(context).isPreMed
                          ? PremedAssets.RedDocument
                          : PremedAssets.BlueDocument,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No Recent Activity',
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  backgroundColor: Colors.grey[300],
                                  value: 0,
                                  valueColor:
                                      AlwaysStoppedAnimation(_getColor(0)),
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                                width: 7,
                              ),
                              Text(
                                '0% Complete',
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getCurrentDateTime(),
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  )),
                              TextButton(
                                onPressed: () {},
                                child: Text('Tutor Mode'.toUpperCase(),
                                    style: PreMedTextTheme().body.copyWith(
                                          color: Provider.of<PreMedProvider>(
                                                      context)
                                                  .isPreMed
                                              ? PreMedColorTheme().red
                                              : PreMedColorTheme().coolBlue,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                        )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor(double progressValue) {
    if (progressValue < 0.3) {
      return PreMedColorTheme().red;
    } else if (progressValue < 0.6) {
      return PreMedColorTheme().yellowlight;
    } else {
      return PreMedColorTheme().greenLight;
    }
  }
}
