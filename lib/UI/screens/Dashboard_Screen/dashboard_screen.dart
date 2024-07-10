import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/Flash_card.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/Qbank_card.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/most_recenet_attempt.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/notes_card.dart';

import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/series_card.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/timer_drop_down.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/notifications/notification_page.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/mdcat/mocks&bank_statistics.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/statistics_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';

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
                      text: "NEWEST RELEAST",
                      text1: "The Ultimate Resource Bank",
                      onTap: () {},
                      icon: PremedAssets.Valut,
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
                      icon: PremedAssets.Savedquestion,
                      text: "Saved",
                      text1: "Questions",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MDcatMockorBankStats(),
                            ));
                      },
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: LatestAttemptScreen(),
              ),
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
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.10),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const StatisticsScreen()));
                                        },
                                        child: Image.asset(
                                          PremedAssets.arrow,
                                          width: 90,
                                          height: 45,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  StatDetailHolder(
                                                    textColor:
                                                        PreMedColorTheme()
                                                            .greenLight,
                                                    count: userStatModel
                                                        .decksAttempted,
                                                    details: 'Decks\nAttempted',
                                                  ),
                                                  StatDetailHolder(
                                                    textColor:
                                                        PreMedColorTheme().red,
                                                    count: userStatModel
                                                        .testAttempted,
                                                    details: 'Test\nAttempted',
                                                  ),
                                                  StatDetailHolder(
                                                    textColor:
                                                        PreMedColorTheme()
                                                            .yellowlight,
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
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
