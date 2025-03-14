
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/dashboard_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/piechart_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/subject_presentage_w.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/timer_card.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';
import 'package:premedpk_mobile_app/providers/statistic_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/vaultProviders/premed_provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late UserStatModel userStatModel;

  String formatTime(int seconds) {
    final double minutes = seconds / 60;

    final double formattedValue = minutes / 1000;

    return formattedValue.toStringAsFixed(3);
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
    userStatProvider.fetchUserStatistics(context);

    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: AppBar( centerTitle: false,
            backgroundColor: Colors.transparent,
            leading: const PopButton(),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              mediaQuery.size.width * 0.015,
              0,
              mediaQuery.size.width * 0.065,
              mediaQuery.size.width * 0.01,
            ),
            child: FutureBuilder(
              future: userStatProvider.fetchUserStatistics(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Provider.of<PreMedProvider>(context).isPreMed
                                ? PreMedColorTheme().red
                                : PreMedColorTheme().blue,
                          ),
                        ],
                      ));
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                } else {
                  userStatModel = userStatProvider.userStatModel!;
                  final computerPercentage = subjectPercentage('Computer');
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
                          left: mediaQuery.size.width * 0.04,
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
                            SizedBox(height: mediaQuery.size.height * 0.03),
                            InkWell(
                              onTap: () {
                                Provider.of<UserStatProvider>(context,
                                    listen: false)
                                    .fetchUserStatistics(context);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    boxShadow: CustomBoxShadow.boxShadow40),
                                child: MaterialCard(
                                  height: mediaQuery.size.height * 0.18,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.2,
                                        height: mediaQuery.size.width * 0.2,
                                        child: ChartCircle(
                                          subjects: const [
                                            'Biology',
                                            'Physics',
                                            'Chemistry',
                                            'Logical Reasoning',
                                            'English',
                                            'Computer Science'
                                          ],
                                          percentages: [
                                            biologyPercentage,
                                            physicsPercentage,
                                            chemistryPercentage,
                                            logicalReaPercentage,
                                            englishPercentage,
                                            computerPercentage
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: mediaQuery.size.width * 0.07),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                if (Provider.of<PreMedProvider>(
                                                    context)
                                                    .isPreMed)
                                                  SubjectPercentage(
                                                    percentage:
                                                    '$biologyPercentage%',
                                                    subject: 'Biology',
                                                    textColor:
                                                    PreMedColorTheme()
                                                        .greenL,
                                                  )
                                                else
                                                  SubjectPercentage(
                                                    percentage:
                                                    '$computerPercentage%',
                                                    subject: 'ComputerScience',
                                                    textColor:
                                                    PreMedColorTheme()
                                                        .primaryColorRed600,
                                                  ),
                                                SubjectPercentage(
                                                    percentage:
                                                    '$physicsPercentage%',
                                                    subject: 'Physics',
                                                    textColor:
                                                    PreMedColorTheme()
                                                        .skyblue),
                                                SubjectPercentage(
                                                  percentage:
                                                  '$chemistryPercentage%',
                                                  subject: 'Chemistry',
                                                  textColor: PreMedColorTheme()
                                                      .redlight,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: mediaQuery.size.height *
                                                    0.01),
                                            Row(
                                              children: [
                                                SubjectPercentage(
                                                  percentage:
                                                  '$logicalReaPercentage%',
                                                  subject: 'Logical Reasoning',
                                                  textColor: PreMedColorTheme()
                                                      .purpulelight,
                                                ),
                                                SizedBox(
                                                    width:
                                                    mediaQuery.size.width *
                                                        0.02),
                                                SubjectPercentage(
                                                  percentage:
                                                  '$englishPercentage%',
                                                  subject: 'English',
                                                  textColor: PreMedColorTheme()
                                                      .orangeLight,
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
                            ),
                            SizedBox(height: mediaQuery.size.height * 0.015),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        boxShadow: CustomBoxShadow.boxShadow40),
                                    child: MaterialCard(
                                      width: mediaQuery.size.width * 0.49,
                                      height: mediaQuery.size.height * 0.19,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              SizedBox(
                                                height: mediaQuery.size.height *
                                                    0.07,
                                                width:
                                                mediaQuery.size.width * 0.4,
                                                child: SvgPicture.asset(
                                                  'assets/images/infocell.svg',
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: mediaQuery.size.width *
                                                    0.0956,
                                                child: Text(
                                                  '${((userStatModel.totalQuestionCorrect / userStatModel.totalQuestionAttempted) * 100).toStringAsFixed(2)}%',
                                                  style: GoogleFonts.rubik(
                                                    height: 1.3,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color:
                                                    PreMedColorTheme().red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: mediaQuery.size.height *
                                                  0.01),
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
                                  ),
                                ),
                                SizedBox(width: mediaQuery.size.width * 0.02),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        boxShadow: CustomBoxShadow.boxShadow40),
                                    child: MaterialCard(
                                      height: mediaQuery.size.height * 0.19,
                                      width: mediaQuery.size.width * 0.49,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                          mediaQuery.size.height * 0.012,
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
                                                color: PreMedColorTheme().red,
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
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mediaQuery.size.height * 0.015),
                            Container(
                              width: 500,
                              height: 137,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: CustomBoxShadow.boxShadow40,
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                child: MaterialCard(
                                  height:
                                  MediaQuery.of(context).size.height * 0.19,
                                  width:
                                  MediaQuery.of(context).size.width * 0.379,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          StatDetailHolder(
                                            textColor:
                                            PreMedColorTheme().greenLight,
                                            count: userStatModel.decksAttempted,
                                            details: 'Decks\nAttempted',
                                          ),
                                          StatDetailHolder(
                                            textColor: PreMedColorTheme().red,
                                            count: userStatModel.testAttempted,
                                            details: 'Test\nAttempted',
                                          ),
                                          StatDetailHolder(
                                            textColor:
                                            PreMedColorTheme().yellowlight,
                                            count: userStatModel
                                                .paracticeTestAttempted,
                                            details:
                                            'Practice Tests\nAttempted',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mediaQuery.size.height * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      boxShadow: CustomBoxShadow.boxShadow40),
                                  child: MaterialCard(
                                    width: mediaQuery.size.width * 0.45,
                                    child: StatDetailHolder1(
                                      textColor: const Color(0xFF60CDBB),
                                      count: formatTime(
                                          userStatModel.totalTimeTaken),
                                      details: 'Total \n Time Taken',
                                      preDetails: 'Minutes',
                                    ),
                                  ),
                                ),
                                SizedBox(width: mediaQuery.size.width * 0.02),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        boxShadow: CustomBoxShadow.boxShadow40),
                                    child: MaterialCard(
                                      child: StatDetailHolder1(
                                        textColor: PreMedColorTheme().red,
                                        count: userStatModel.avgTimePerQuestion
                                            .toStringAsFixed(0),
                                        details: 'Avg.Time Per \n Question',
                                        preDetails: 'Seconds',
                                      ),
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
