// ignore: file_namessf
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/piechart_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/subject_presentage_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/timer_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';
import 'package:premedpk_mobile_app/providers/statistic_provider.dart';

import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;

    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  late UserStatModel userStatModel;
  String subjectPercentage(String subject) {
    final enteredSubject = userStatModel.subjectAttempts.firstWhere(
      (subjectAttempt) => subjectAttempt.subject == subject,
      orElse: () => SubjectAttempt(
        subject: subject,
        totalQuestionsAttempted: 0,
        totalQuestionsCorrect: 0,
        totalQuestionsIncorrect: 0,
      ),
    );
    if (enteredSubject.totalQuestionsAttempted == 0) {
      return '0';
    }
    final subjectPercentage = ((enteredSubject.totalQuestionsAttempted /
                userStatModel.totalQuestionAttempted) *
            100)
        .toStringAsFixed(0);
    return subjectPercentage;
  }

  @override
  Widget build(BuildContext context) {
    final UserStatProvider userStatProvider =
        Provider.of<UserStatProvider>(context, listen: false);
    userStatProvider.fetchUserStatistics();
    return Scaffold(
      backgroundColor: const Color(0xFFFBF0F3),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: 37,
                height: 37,
                child: SvgPicture.asset(
                  'assets/icons/left-arrow.svg',
                  width: 9.33,
                  height: 18.67,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 23, 10),
            child: FutureBuilder(
              future: userStatProvider.fetchUserStatistics(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle errors
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                } else {
                  userStatModel = userStatProvider.userStatModel!;
                  final biologyPercentage = subjectPercentage('Biology');
                  final physicsPercentage = subjectPercentage('Physics');
                  final chemistryPercentage = subjectPercentage('Chemistry');
                  final logicalReaPercentage =
                      subjectPercentage('Logical Reasoning');
                  final englishPercentage = subjectPercentage('English');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2% of screen height
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Statistics",
                              style: PreMedTextTheme().heading4.copyWith(
                                  fontWeight: FontWeight.w800, fontSize: 28),
                            ),
                            Text(
                              'Your performance, facts and figures, all at a glance!',
                              style:
                                  PreMedTextTheme().body.copyWith(fontSize: 17),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {
                                Provider.of<UserStatProvider>(context,
                                        listen: false)
                                    .fetchUserStatistics();
                              },
                              child: MaterialCard(
                                height: 150,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: ChartCircle(
                                        subjects: const [
                                          'Biology',
                                          'Physics',
                                          'Chemistry',
                                          'Logical Reasoning',
                                          'English'
                                        ],
                                        percentages: [
                                          biologyPercentage,
                                          physicsPercentage,
                                          chemistryPercentage,
                                          logicalReaPercentage,
                                          englishPercentage
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SubjectPercentage(
                                                percentage:
                                                    '$biologyPercentage%',
                                                subject: 'Biology',
                                                textColor:
                                                    const Color(0xFF42C96B),
                                              ),
                                              SubjectPercentage(
                                                percentage:
                                                    '$physicsPercentage%',
                                                subject: 'Physics',
                                                textColor:
                                                    const Color(0xFF0383BB),
                                              ),
                                              SubjectPercentage(
                                                percentage:
                                                    '$chemistryPercentage%',
                                                subject: 'Chemistry',
                                                textColor:
                                                    const Color(0xFFC40052),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SubjectPercentage(
                                                percentage:
                                                    '$logicalReaPercentage%',
                                                subject: 'Logical Reasoning',
                                                textColor:
                                                    const Color(0xFF8800C3),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              SubjectPercentage(
                                                percentage:
                                                    '$englishPercentage%',
                                                subject: 'English',
                                                textColor:
                                                    const Color(0xFFFB9666),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                MaterialCard(
                                  width: 200,
                                  height: 153,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        SizedBox(
                                          height: 60,
                                          width: 210,
                                          child: SvgPicture.asset(
                                              'assets/images/infocell.svg'),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 51,
                                          child: Text(
                                            '${((userStatModel.totalQuestionCorrect / userStatModel.totalQuestionAttempted) * 100).toStringAsFixed(2)}%',
                                            style: GoogleFonts.rubik(
                                              height: 1.3,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: const Color(0xFFEC5863),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      SizedBoxes.vertical10Px,
                                      Text(
                                        'Accuracy',
                                        style: GoogleFonts.rubik(
                                          height: 1.3,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: const Color(0xFF000000),
                                        ),
                                      ),
                                      Text(
                                        'EXCELLENT',
                                        style: GoogleFonts.rubik(
                                          height: 1.3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: const Color(0xFF059669),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                MaterialCard(
                                  height: 150,
                                  width: 140,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, bottom: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${userStatModel.totalQuestionAttempted}',
                                          style: GoogleFonts.rubik(
                                            height: 1.3,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 29,
                                            color: const Color(0xFFEC5863),
                                          ),
                                        ),
                                        Text(
                                          'Total Questions\nAttempted',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.rubik(
                                            height: 1.3,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: const Color(0xFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            MaterialCard(
                              height: 128,
                              width: 400,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StatDetailHolder(
                                          textColor: const Color(0xFF60CDBB),
                                          count: userStatModel.decksAttempted,
                                          details: 'Decks\nAttempted'),
                                      StatDetailHolder(
                                          textColor: const Color(0xFFEC5863),
                                          count: userStatModel.testAttempted,
                                          details: 'Test\nAttempted'),
                                      StatDetailHolder(
                                          textColor: const Color(0xFFFFC372),
                                          count: userStatModel
                                              .paracticeTestAttempted,
                                          details: 'Practice Tests\nAttempted'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialCard(
                              width: 200,
                              child: StatDetailHolder1(
                                  textColor: const Color(0xFF60CDBB),
                                  count:
                                      formatTime(userStatModel.totalTimeTaken),
                                  details: 'Total \n Time Taken',
                                  preDetails: 'Minutes'),
                            ),
                            SizedBoxes.horizontalTiny,
                            Expanded(
                              child: MaterialCard(
                                child: StatDetailHolder1(
                                  textColor: const Color(0xFFEC5863),
                                  count: userStatModel.avgTimePerQuestion,
                                  details: 'Avg.Time Per \n Question',
                                  preDetails: 'Seconds',
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
