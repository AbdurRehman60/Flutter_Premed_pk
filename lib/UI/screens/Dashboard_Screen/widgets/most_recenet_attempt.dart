import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/recent_activity_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/lastest_attempts_provider.dart';
import 'package:provider/provider.dart';

class LatestAttemptScreen extends StatelessWidget {
  const LatestAttemptScreen({super.key, required this.isPreMed});
  final bool isPreMed;

  @override
  Widget build(BuildContext context) {
    String getCurrentDateTime() {
      final DateTime now = DateTime.now();
      return DateFormat('d MMMM yyyy, h:mm a').format(now); // Format as desired
    }

    return FutureBuilder<void>(
      future: Provider.of<LatestAttemptPro>(context, listen: false)
          .fetchLatestAttempt(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Container(),
          );
        } else {
          return Consumer<LatestAttemptPro>(
            builder: (context, latestAttemptProvider, _) {
              switch (latestAttemptProvider.status) {
                case FetchAttemptStatus.init:
                case FetchAttemptStatus.fetching:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case FetchAttemptStatus.success:
                  final latestAttempt = latestAttemptProvider.latestAttempt;
                  if (latestAttempt != null &&
                      latestAttempt.results.isNotEmpty) {
                    return RecentActivityCard(
                      isPreMed: isPreMed,
                      acivityname: latestAttempt.results.first.deckName,
                      date: latestAttempt.results.first.createdAt,
                      progressValue: latestAttempt.results.first.totalAttempts /
                          latestAttempt.results.first.totalQuestions,
                      mode: latestAttempt.results.first.attemptMode,
                    );
                  } else {
                    return const Center(
                      child: Text('No attempts available'),
                    );
                  }
                case FetchAttemptStatus.error:
                  return Card(
                    elevation: 5,
                    child: Container(
                      height: 182,
                      decoration: BoxDecoration(
                        color: PreMedColorTheme().white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text('Recent Activity',
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color: const Color.fromARGB(
                                                255, 74, 74, 74))),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        color: PreMedColorTheme().red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50, right: 5),
                                  child: Image.asset(
                                    "assets/images/QuestionMarkDocument.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(25)),
                                                backgroundColor:
                                                    Colors.grey[300],
                                                value: 0,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        _getColor(0)),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getCurrentDateTime(),
                                                style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10,
                                                )),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text('Tutor Mode',
                                                  style: GoogleFonts.rubik(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12,
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
            },
          );
        }
      },
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
