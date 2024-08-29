import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/Flash_card.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/Qbank_card.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/most_recenet_attempt.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/notes_card.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/series_card.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/widgets/timer_widgets.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/studynotes.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/vault_home.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/account_before_edit.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/statistics_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';
import 'package:premedpk_mobile_app/providers/statistic_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/recent_atempts_provider.dart';
import '../The vault/saved_question/saved_question_screen.dart';

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
  Future<void> _loadRecentAttempts() async {
    final userId = Provider.of<UserProvider>(context, listen: false).user?.userId;
    if (userId != null) {
      await Provider.of<RecentAttemptsProvider>(context, listen: false).fetchRecentAttempts(userId);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRecentAttempts();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final UserStatProvider userStatProvider =
        Provider.of<UserStatProvider>(context, listen: false);
    userStatProvider.fetchUserStatistics(context);
    return Scaffold(
      backgroundColor: PreMedColorTheme().background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                              return GestureDetector(
                                onTap: (){
                                 final userProvider  = Provider.of<UserProvider>(context,listen: false);
                                 final page = userProvider.user?.info.lastOnboardingPage;
                                 print('onBoardingPage : $page');
                                },
                                child: Text('Hi, ${userProvider.getUserName()}',
                                    style: PreMedTextTheme().heading4.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 28)),
                              );
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
                            builder: (context) => const AccountBeforeEdit(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            boxShadow: CustomBoxShadow.boxShadow40),
                        child: SvgPicture.asset(
                            Provider.of<PreMedProvider>(context).isPreMed
                                ? PremedAssets.Profile
                                : PremedAssets.blueProfle),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.03, top: screenHeight * 0.01),
                child: Row(
                  children: [
                    NotesCard(
                      icon: PremedAssets.notesstudy,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const StudyNotesHome()));
                      },
                      bgColor: PreMedColorTheme().white85,
                      text: 'Continue Studying'.toUpperCase(),
                      text1: Provider.of<PreMedProvider>(context).isPreMed
                          ? 'Stichiometery'
                          : 'Measurements',
                      text2: 'STUDY NOTES',
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    SeriesCard(
                      bgColor: PreMedColorTheme().white85,
                      text: "NEWEST RELEAST",
                      text1: "The Ultimate Resource Bank",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VaultHome()));
                      },
                      icon: PremedAssets.Valut,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.03, top: screenHeight * 0.01),
                child: Row(
                  children: [
                    QbankCard(
                      bgColor: PreMedColorTheme().white85,
                      icon: PremedAssets.Savedquestion,
                      text: "Saved",
                      text1: "Questions",
                      isPreMed: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SavedQuestionScreen(),
                            ));
                      },
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    FlashCard(
                      bgColor: PreMedColorTheme().white85,
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
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.043,
                    vertical: screenHeight * 0.015),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          boxShadow: CustomBoxShadow.boxShadow40,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: const TimerClass()
                      // const TimerWidget()
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
                child: const LatestAttemptScreen(
                  isPreMed: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.045,
                    vertical: screenHeight * 0.017),
                child: Container(
                  width: screenWidth * 7,
                  height: screenHeight * 0.32,
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().white85,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: CustomBoxShadow.boxShadow40,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: FutureBuilder(
                        future: userStatProvider.fetchUserStatistics(context),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (userStatProvider.userStatModel == null) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Image.asset(
                                          Provider.of<PreMedProvider>(context)
                                                  .isPreMed
                                              ? PremedAssets.graph
                                              : PremedAssets.BlueGraph,
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
                                      SizedBox(width: screenWidth * 0.08),
                                      InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                          Provider.of<PreMedProvider>(context)
                                              .isPreMed
                                              ? PremedAssets.arrow
                                              : PremedAssets.blueAerrow,
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      height: screenHeight * 0.18,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        boxShadow:
                                            CustomBoxShadow.boxShadow40,
                                      ),
                                      child: MaterialCard(
                                        height: screenHeight * 0.18,
                                        width: screenWidth,
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
                                                  count: 0,
                                                  details: 'Decks\nAttempted',
                                                ),
                                                StatDetailHolder(
                                                  textColor:
                                                      PreMedColorTheme().red,
                                                  count: 0,
                                                  details: 'Test\nAttempted',
                                                ),
                                                StatDetailHolder(
                                                  textColor:
                                                      PreMedColorTheme()
                                                          .yellowlight,
                                                  count: 0,
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
                                ],
                              );
                            }
                            userStatModel = userStatProvider.userStatModel!;
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        Provider.of<PreMedProvider>(context)
                                                .isPreMed
                                            ? PremedAssets.graph
                                            : PremedAssets.BlueGraph,
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
                                    SizedBox(width: screenWidth * 0.08),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const StatisticsScreen(),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        Provider.of<PreMedProvider>(context)
                                            .isPreMed
                                            ? PremedAssets.arrow
                                            : PremedAssets.blueAerrow,
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: screenHeight * 0.18,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: CustomBoxShadow.boxShadow40,
                                    ),
                                    child: MaterialCard(
                                      height: screenHeight * 0.18,
                                      width: screenWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              StatDetailHolder(
                                                textColor: PreMedColorTheme()
                                                    .greenLight,
                                                count: userStatModel
                                                    .decksAttempted,
                                                details: 'Decks\nAttempted',
                                              ),
                                              StatDetailHolder(
                                                textColor:
                                                    PreMedColorTheme().red,
                                                count:
                                                    userStatModel.testAttempted,
                                                details: 'Test\nAttempted',
                                              ),
                                              StatDetailHolder(
                                                textColor: PreMedColorTheme()
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
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        Provider.of<PreMedProvider>(context)
                                                .isPreMed
                                            ? PremedAssets.graph
                                            : PremedAssets.BlueGraph,
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
                                    SizedBox(width: screenWidth * 0.08),
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        Provider.of<PreMedProvider>(context)
                                            .isPreMed
                                            ? PremedAssets.arrow
                                            : PremedAssets.blueAerrow,
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    height: screenHeight * 0.18,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: CustomBoxShadow.boxShadow40,
                                    ),
                                    child: MaterialCard(
                                      height: screenHeight * 0.18,
                                      width: screenWidth,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              StatDetailHolder(
                                                textColor: PreMedColorTheme()
                                                    .greenLight,
                                                count: 0,
                                                details: 'Decks\nAttempted',
                                              ),
                                              StatDetailHolder(
                                                textColor:
                                                    PreMedColorTheme().red,
                                                count: 0,
                                                details: 'Test\nAttempted',
                                              ),
                                              StatDetailHolder(
                                                textColor: PreMedColorTheme()
                                                    .yellowlight,
                                                count: 0,
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
                              ],
                            );
                          }
                        },
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

class CustomBoxShadow {
  static const List<BoxShadow> boxShadow40 = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 40,
      offset: Offset(0, 20),
    ),
  ];
}
