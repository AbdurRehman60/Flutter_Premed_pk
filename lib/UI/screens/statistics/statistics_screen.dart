import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';
import 'package:premedpk_mobile_app/providers/statistic_provider.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/piechart_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/subject_presentage_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/timer_card.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late UserStatModel userStatModel;

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;

    final String minutesStr = minutes.toString().padLeft(2, '0');
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

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

    // MediaQueryData to access device screen dimensions
    final MediaQueryData mediaQuery = MediaQuery.of(context);

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
                width: mediaQuery.size.width * 0.1, // 10% of screen width
                height: mediaQuery.size.width * 0.1, // 10% of screen width
                child: SvgPicture.asset(
                  'assets/icons/left-arrow.svg',
                  width: mediaQuery.size.width * 0.025, // 2.5% of screen width
                  height: mediaQuery.size.width * 0.05, // 5% of screen width
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              mediaQuery.size.width * 0.015, // 1.5% of screen width
              0,
              mediaQuery.size.width * 0.065, // 6.5% of screen width
              mediaQuery.size.width * 0.01, // 1% of screen width
            ),
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
                      Padding(
                        padding: EdgeInsets.only(
                          left: mediaQuery.size.width *
                              0.04, // 4% of screen width
                        ),
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
                            SizedBox(
                                height: mediaQuery.size.height *
                                    0.03), // 3% of screen height
                            InkWell(
                              onTap: () {
                                Provider.of<UserStatProvider>(context,
                                        listen: false)
                                    .fetchUserStatistics();
                              },
                              child: MaterialCard(
                                height: mediaQuery.size.height *
                                    0.18, // 18% of screen height
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: mediaQuery.size.width *
                                          0.2, // 20% of screen width
                                      height: mediaQuery.size.width *
                                          0.2, // 20% of screen width
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
                                    SizedBox(
                                        width: mediaQuery.size.width *
                                            0.07), // 2% of screen width
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
                                          SizedBox(
                                              height: mediaQuery.size.height *
                                                  0.01), // 1% of screen height
                                          Row(
                                            children: [
                                              SubjectPercentage(
                                                percentage:
                                                    '$logicalReaPercentage%',
                                                subject: 'Logical Reasoning',
                                                textColor:
                                                    const Color(0xFF8800C3),
                                              ),
                                              SizedBox(
                                                  width: mediaQuery.size.width *
                                                      0.02), // 2% of screen width
                                              SubjectPercentage(
                                                percentage:
                                                    '$englishPercentage%',
                                                subject: 'English',
                                                textColor:
                                                    const Color(0xFFFB9666),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height: mediaQuery.size.height *
                                    0.015), // 2.5% of screen height
                            Row(
                              children: [
                                MaterialCard(
                                  width: mediaQuery.size.width *
                                      0.49, // 27% of screen width
                                  height: mediaQuery.size.height *
                                      0.19, // 20% of screen height
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: mediaQuery.size.height *
                                                0.07, // 8% of screen height
                                            width: mediaQuery.size.width *
                                                0.4, // 30% of screen width
                                            child: SvgPicture.asset(
                                              'assets/images/infocell.svg',
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: mediaQuery.size.width *
                                                0.12, // 8% of screen width
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
                                        ],
                                      ),
                                      SizedBox(
                                          height: mediaQuery.size.height *
                                              0.01), // 1% of screen height
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
                                SizedBox(
                                    width: mediaQuery.size.width *
                                        0.02), // 2% of screen width
                                MaterialCard(
                                  height: mediaQuery.size.height *
                                      0.18, // 18% of screen height
                                  width: mediaQuery.size.width *
                                      0.37, // 18% of screen width
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.size.height *
                                          0.012, // 1.2% of screen height
                                    ),
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
                            SizedBox(
                                height: mediaQuery.size.height *
                                    0.015), // 2.5% of screen height
                            MaterialCard(
                              height: mediaQuery.size.height *
                                  0.16, // 15% of screen height
                              width: mediaQuery.size.width *
                                  0.90, // 40% of screen width
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
                                        details: 'Decks\nAttempted',
                                      ),
                                      StatDetailHolder(
                                        textColor: const Color(0xFFEC5863),
                                        count: userStatModel.testAttempted,
                                        details: 'Test\nAttempted',
                                      ),
                                      StatDetailHolder(
                                        textColor: const Color(0xFFFFC372),
                                        count: userStatModel
                                            .paracticeTestAttempted,
                                        details: 'Practice Tests\nAttempted',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: mediaQuery.size.height *
                                    0.015), // 2.5% of screen height
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialCard(
                                  width: mediaQuery.size.width *
                                      0.45, // 25% of screen width
                                  child: StatDetailHolder1(
                                    textColor: const Color(0xFF60CDBB),
                                    count: formatTime(
                                        userStatModel.totalTimeTaken),
                                    details: 'Total \n Time Taken',
                                    preDetails: 'Minutes',
                                  ),
                                ),
                                SizedBox(
                                    width: mediaQuery.size.width *
                                        0.02), // 2% of screen width
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
                          ],
                        ),
                      ),
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
