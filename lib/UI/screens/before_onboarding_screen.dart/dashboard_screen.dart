import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/Flash_card.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/Qbank_card.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/notes_card.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/recent_activity_card.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/series_card.dart';
import 'package:premedpk_mobile_app/UI/screens/before_onboarding_screen.dart/widgets/timer_drop_down.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/notifications/notification_page.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/mdcat/mocks&bank_statistics.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/statistics_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';
import 'package:premedpk_mobile_app/providers/lastest_attempts_provider.dart';
import 'package:premedpk_mobile_app/providers/statistic_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.uni, this.timeLeft});
  final String? uni;
  final String? timeLeft;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      backgroundColor: PreMedColorTheme().background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                            if (userProvider.user == null) {
                              return Text('Hi,Guest',
                                  style: PreMedTextTheme().heading4.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 26));
                            } else {
                              return Text('Hi, ${userProvider.getUserName()}',
                                  style: PreMedTextTheme().heading4.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 28));
                            }
                          },
                        ),
                        Text(
                          "Let's resume our journey!",
                          style: PreMedTextTheme().body.copyWith(
                                fontSize: 17,
                                color: PreMedColorTheme().red,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ),
                        );
                      },
                      child: Image.asset(
                        PremedAssets.NotificationIcon,
                        width: 27,
                        height: 27,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Row(
                  children: [
                    NotesCard(
                      icon: PremedAssets.notesstudy,
                      onTap: () {},
                      bgColor: PreMedColorTheme().white,
                      text: 'CONTINUE STUDYING',
                      text1: 'Hydrocarbons',
                      text2: 'STUDY NOTES',
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    SeriesCard(
                      bgColor: PreMedColorTheme().white,
                      text: "AVAILABLE NOW",
                      text1: "FSc-II EXAMS - PUNJAB 2024",
                      onTap: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  children: [
                    QbankCard(
                      bgColor: PreMedColorTheme().white,
                      icon: PremedAssets.QuestionBank,
                      text: "PREVIOUS ACTIVITY",
                      text1: "MDCAT",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MDcatMockorBankStats(),
                            ));
                      },
                      text2: "QBank",
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    FlashCard(
                      bgColor: PreMedColorTheme().white,
                      icon: PremedAssets.Flashcards,
                      text1: 'Flashcards',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FlashcardHome(),
                          ),
                        );
                      },
                      text2: 'Fast-paced revision!',
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: 400,
                    height: 163,
                    child:
                        DropDown(timeLeft: widget.timeLeft, uni: "Not Select")),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, right: 10),
              //   child: ChangeNotifierProvider(
              //     create: (_) => LatestAttemptProvider(),
              //     child: Consumer<LatestAttemptProvider>(
              //       builder: (context, provider, child) {
              //         if (provider.isLoading) {
              //           return const Center(child: CircularProgressIndicator());
              //         } else if (provider.latestAttemptError != null) {
              //           return Text('Error: ${provider.latestAttemptError}');
              //         } else {
              //           if (provider.latestAttempt!.results!.isNotEmpty) {
              //             final result = provider.latestAttempt!.results![0];
              //             return RecentActivityCard(
              //               acivityname: result.deckName ?? '',
              //               date: result.attemptedDate.toString(),
              //               progressValue:
              //                   result.totalAttempts! / result.totalQuestions!,
              //             );
              //           } else {
              //             return const Text('No results found');
              //           }
              //         }
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Card(
                  elevation: 5,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 7,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: PreMedColorTheme().white,
                        borderRadius: BorderRadius.circular(12),
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
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: FutureBuilder(
                          future: userStatProvider.fetchUserStatistics(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                userStatModel = userStatProvider.userStatModel!;
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Image.asset(
                                            PremedAssets.graph,
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 2, bottom: 7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Statistics",
                                                style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "Check out your performance at a glance!",
                                                style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 9,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const StatisticsScreen()));
                                          },

                                          child: SvgPicture.asset(
                                            PremedAssets.RightArrow,
                                            width: 12,
                                            height: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Card(
                                        elevation: 5,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 180, 180, 180)
                                                    .withOpacity(0.1),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: MaterialCard(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    StatDetailHolder(
                                                      count: 15,
                                                      details:
                                                          'Decks\nAttempted',
                                                      textColor:
                                                          Color(0xFF60CDBB),
                                                    ),
                                                    StatDetailHolder(
                                                      count: 5,
                                                      details:
                                                          'Test\nAttempted',
                                                      textColor:
                                                          Color(0xFFEC5863),
                                                    ),
                                                    StatDetailHolder(
                                                      count: 8,
                                                      details:
                                                          'Practice Tests\nAttempted',
                                                      textColor:
                                                          Color(0xFFFFC372),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }
                          },
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
