import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/chart_circle.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/material_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/stat_details_holder.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/subject_percentage.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../models/userstat_model.dart';
import '../../../providers/statistic_provider.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(23, 10, 23, 10),
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
                      Text(
                        'Statistics',
                        style: GoogleFonts.rubik(
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      SizedBoxes.vertical3Px,
                      Text(
                        'Your PreMed Statistics and Performance Overview',
                        style: GoogleFonts.rubik(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      SizedBoxes.verticalBig,
                      InkWell(
                        onTap: () {
                          Provider.of<UserStatProvider>(context, listen: false)
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
                                          percentage: '$biologyPercentage%',
                                          subject: 'Biology',
                                          textColor: const Color(0xFF42C96B),
                                        ),
                                        SubjectPercentage(
                                          percentage: '$physicsPercentage%',
                                          subject: 'Physics',
                                          textColor: const Color(0xFF0383BB),
                                        ),
                                        SubjectPercentage(
                                          percentage: '$chemistryPercentage%',
                                          subject: 'Chemistry',
                                          textColor: const Color(0xFFC40052),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SubjectPercentage(
                                          percentage: '$logicalReaPercentage%',
                                          subject: 'Logical Reasoning',
                                          textColor: const Color(0xFF8800C3),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SubjectPercentage(
                                          percentage: '$englishPercentage%',
                                          subject: 'English',
                                          textColor: const Color(0xFFFB9666),
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
                      SizedBoxes.verticalBig,
                      Row(
                        children: [
                          MaterialCard(
                            height: 164,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  SizedBox(
                                    height: 75,
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
                                    fontSize: 8,
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
                          SizedBoxes.horizontalTiny,
                          MaterialCard(
                            height: 164,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${userStatModel.totalQuestionAttempted}',
                                  style: GoogleFonts.rubik(
                                    height: 1.3,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24,
                                    color: const Color(0xFFEC5863),
                                  ),
                                ),
                                Text(
                                  'Total Questions\nAttempted',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rubik(
                                    height: 1.3,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBoxes.verticalBig,
                      MaterialCard(
                        height: 121,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    count: userStatModel.paracticeTestAttempted,
                                    details: 'Practice Tests\nAttempted'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBoxes.verticalBig,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MaterialCard(
                              child: StatDetailHolder(
                                  textColor: const Color(0xFF60CDBB),
                                  count:
                                      formatTime(userStatModel.totalTimeTaken),
                                  details: 'Total \n Time Taken',
                                  preDetails: 'Minutes'),
                            ),
                          ),
                          SizedBoxes.horizontalTiny,
                          Expanded(
                            child: MaterialCard(
                              child: StatDetailHolder(
                                textColor: const Color(0xFFEC5863),
                                count: userStatModel.avgTimePerQuestion,
                                details: 'Avg.Time Per \n Question',
                                preDetails: 'Seconds',
                              ),
                            ),
                          ),
                        ],
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
