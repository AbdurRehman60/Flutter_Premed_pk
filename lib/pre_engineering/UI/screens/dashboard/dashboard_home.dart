import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/pre_eng/screens/study_notes_home_eng.dart';
import 'package:premedpk_mobile_app/UI/screens/account/widgets/account_before_edit.dart';
import 'package:premedpk_mobile_app/pre_engineering/UI/widgets/eng_timer.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import '../../../../UI/screens/Dashboard_Screen/dashboard_screen.dart';
import '../../../../UI/screens/Dashboard_Screen/widgets/Flash_card.dart';
import '../../../../UI/screens/Dashboard_Screen/widgets/Qbank_card.dart';
import '../../../../UI/screens/Dashboard_Screen/widgets/most_recenet_attempt.dart';
import '../../../../UI/screens/Dashboard_Screen/widgets/notes_card.dart';
import '../../../../UI/screens/Dashboard_Screen/widgets/series_card.dart';
import '../../../../UI/screens/The vault/pre_eng/screens/pre_eng_vault_home.dart';
import '../../../../UI/screens/flashcards/flashcards_home.dart';
import '../../../../UI/screens/statistics/statistics_screen.dart';
import '../../../../UI/screens/statistics/widgets/Attempted_card.dart';
import '../../../../UI/screens/statistics/widgets/card_w.dart';
import '../../../../constants/constants_export.dart';
import '../../../../models/statistic_model.dart';
import '../../../../providers/recent_atempts_provider.dart';
import '../../../../providers/statistic_provider.dart';
import '../../../../providers/user_provider.dart';
import '../saved_question/saved_question_eng.dart';

class EngineeringDashboardScreen extends StatefulWidget {
  const EngineeringDashboardScreen({super.key, this.timeLeft});

  final String? timeLeft;

  @override
  State<EngineeringDashboardScreen> createState() =>
      _EngineeringDashboardScreenState();
}

class _EngineeringDashboardScreenState
    extends State<EngineeringDashboardScreen> {
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
    userStatProvider.fetchUserStatistics('');
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
                    horizontal: MediaQuery.of(context).size.width * 0.05
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              return Text(
                                userProvider.user == null
                                    ? 'Hi, Guest'
                                    : 'Hi, ${userProvider.getUserName()}',
                                style: PreMedTextTheme().heading4.copyWith(
                                  fontWeight: userProvider.user == null
                                      ? FontWeight.w700
                                      : FontWeight.w800,
                                  fontSize: userProvider.user == null
                                      ? 26
                                      : 28,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,// Ensures text doesn't overflow
                              );
                            },
                          ),
                          Text(
                            "Let's resume our journey!",
                            style: PreMedTextTheme().body.copyWith(
                              fontSize: 17,
                              color: Provider.of<PreMedProvider>(context).isPreMed
                                  ? PreMedColorTheme().red
                                  : PreMedColorTheme().blue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          boxShadow: CustomBoxShadow.boxShadow40
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AccountBeforeEdit()
                              )
                          );
                        },
                        child: SvgPicture.asset(
                            Provider.of<PreMedProvider>(context).isPreMed
                                ? PremedAssets.Profile
                                : PremedAssets.blueProfle
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03)
                    .copyWith(top: 10),
                child: Row(
                  children: [
                    NotesCard(
                      icon: PremedAssets.notesstudy,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EngineeringStudyNotesHome()));
                      },
                      bgColor: PreMedColorTheme().white85,
                      text: 'Continue Studying'.toUpperCase(),
                      text1:  Provider.of<PreMedProvider>(context).isPreMed ? 'Stichiometery' : 'Measurements',
                      text2: 'STUDY NOTES',
                    ),
                    SizedBox(
                      width: screenWidth * 0.01,
                    ),
                    SeriesCard(
                      bgColor: PreMedColorTheme().white,
                      text: "NEWEST RELEAST",
                      text1: "The Ultimate Resource Bank",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PreEngVaultHome()));
                      },
                      icon: PremedAssets.Valut,
                    )
                  ],
                ),
              ),
              SizedBoxes.vertical10Px,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  children: [
                    QbankCard(
                      bgColor: PreMedColorTheme().white,
                      icon: PremedAssets.Savedquestion,
                      text: "Saved",
                      text1: "Questions",
                      isPreMed: false,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const SavedQuestionScreenEng(),
                            ));
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    FlashCard(
                      bgColor: PreMedColorTheme().white,
                      icon: PremedAssets.Flashcards,
                      text1: 'Saved Facts',
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
              SizedBoxes.vertical15Px,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.043,),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: CustomBoxShadow.boxShadow40,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: const EngineeringTimer(),
                    // const TimerWidget()
                  ),
                ),
              ),
              SizedBoxes.vertical15Px,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04)
                    .copyWith(bottom: 10),
                child: const LatestAttemptScreen(
                  isPreMed: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.045,
                    vertical: screenHeight * 0.009),
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