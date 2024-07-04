// import 'package:flutter/foundation.dart';

// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:premedpk_mobile_app/UI/new_home_page/widgets/Flash_card.dart';
// import 'package:premedpk_mobile_app/UI/new_home_page/widgets/Qbank_card.dart';
// import 'package:premedpk_mobile_app/UI/new_home_page/widgets/notes_card.dart';
// import 'package:premedpk_mobile_app/UI/new_home_page/widgets/series_card.dart';
// import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';

// import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/question_of_day_card.dart';
// import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/recentActivityCard.dart';
// import 'package:premedpk_mobile_app/UI/screens/notifications/notification_page.dart';
// import 'package:premedpk_mobile_app/UI/screens/qbank/mdcat/mocks&bank_statistics.dart';
// import 'package:premedpk_mobile_app/UI/screens/statistics/statistics_screen.dart';
// import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
// import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
// import 'package:premedpk_mobile_app/constants/constants_export.dart';
// import 'package:premedpk_mobile_app/models/recent_attempts_model.dart';
// import 'package:premedpk_mobile_app/models/statistic_model.dart';
// import 'package:premedpk_mobile_app/providers/recent_atempts_provider.dart';
// import 'package:premedpk_mobile_app/providers/statistic_provider.dart';
// import 'package:premedpk_mobile_app/providers/user_provider.dart';
// import 'package:provider/provider.dart';

// class NewHomePage extends StatefulWidget {
//   const NewHomePage({super.key});

//   @override
//   State<NewHomePage> createState() => _NewHomePageState();
// }

// class _NewHomePageState extends State<NewHomePage> {
//   late UserStatModel userStatModel;
//   String subjectPercentage(String subject) {
//     final enteredSubject = userStatModel.subjectAttempts.firstWhere(
//       (subjectAttempt) => subjectAttempt.subject == subject,
//       orElse: () => SubjectAttempt(
//         subject: subject,
//         totalQuestionsAttempted: 0,
//         totalQuestionsCorrect: 0,
//         totalQuestionsIncorrect: 0,
//       ),
//     );
//     if (enteredSubject.totalQuestionsAttempted == 0) {
//       return '0';
//     }
//     final subjectPercentage = ((enteredSubject.totalQuestionsAttempted /
//                 userStatModel.totalQuestionAttempted) *
//             100)
//         .toStringAsFixed(0);
//     return subjectPercentage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final UserStatProvider userStatProvider =
//         Provider.of<UserStatProvider>(context, listen: false);
//     userStatProvider.fetchUserStatistics();
//     return Scaffold(
//       backgroundColor: const Color(0xFFFBF0F3),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.02,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: MediaQuery.of(context).size.width * 0.07),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Consumer<UserProvider>(
//                           builder: (context, userProvider, child) {
//                             return Text(
//                               'Hi, ${userProvider.getUserName()}',
//                               style: PreMedTextTheme().heading4.copyWith(
//                                   fontWeight: FontWeight.w800, fontSize: 28),
//                             );
//                           },
//                         ),
//                         Text(
//                           'Ready to continue your journey?',
//                           style: PreMedTextTheme().body.copyWith(fontSize: 17),
//                         ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => const NotificationPage(),
//                             ),
//                           );
//                         },
//                         child: Image.asset(
//                           PremedAssets.NotificationIcon,
//                           width: 35,
//                           height: 35,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(left: 10, top: 20),
//                 child: Row(
//                   children: [
//                     NotesCard(
//                       icon: PremedAssets.notesstudy,
//                       onTap: () {},
//                       bgColor: Colors.white,
//                       text: 'CONTINUE STUDYING',
//                       text1: 'Hydrocarbons',
//                       text2: 'STUDY NOTES',
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     SeriesCard(
//                       bgColor: Colors.white,
//                       text: "AVAILABLE NOW",
//                       text1: "FSc-II EXAMS - PUNJAB 2024",
//                       onTap: () {},
//                     )
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.only(left: 10, top: 20),
//                 child: Row(
//                   children: [
//                     QbankCard(
//                       bgColor: Colors.white,
//                       icon: PremedAssets.QuestionBank,
//                       text: "PREVIOUS ACTIVITY",
//                       text1: "MDCAT",
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   const MDcatMockorBankStats(),
//                             ));
//                       },
//                       text2: "QBank",
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     FlashCard(
//                       bgColor: Colors.white,
//                       icon: PremedAssets.Flashcards,
//                       text1: 'Flashcards',
//                       onTap: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (context) => const FlashcardHome(),
//                           ),
//                         );
//                       },
//                       text2: 'Fast-paced revision!',
//                     )
//                   ],
//                 ),
//               ),
//               const QuestionCard(
//                 question:
//                     'What is the other name of the magnetic field intensity?',
//                 tags: ['physics', 'Electromagnetism'],
//                 isResource: false,
//               ),

//               // const Padding(
//               //   padding: EdgeInsets.only(left: 10, right: 13),
//               //   child: RecentActivityCard(
//               //       acivityname: "Alkyl Halides and Amines Past Paper",
//               //       date: "26th Feb 2024",
//               //       progressValue: 0.0),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 13, right: 13),
//                 child: Consumer<RecentAttemptsProvider>(
//                   builder: (context, recentAttemptsProvider, child) {
//                     if (kDebugMode) {
//                       print(
//                           'Recent attempts: ${recentAttemptsProvider.recentAttempts.length}');
//                     }

//                     RecentAttempt recentAttempt =
//                         recentAttemptsProvider.recentAttempts.isNotEmpty
//                             ? recentAttemptsProvider.recentAttempts.first
//                             : RecentAttempt(
//                                 deckName: '',
//                                 attemptedDate: DateTime.now(),
//                                 totalAttempts: 0,
//                                 totalQuestions: 0);

//                     if (kDebugMode) {
//                       print('Recent attempt: $recentAttempt');
//                     }

//                     double progressValue;
//                     if (recentAttempt.totalAttempts != null &&
//                         recentAttempt.totalQuestions != null &&
//                         recentAttempt.totalQuestions! > 0) {
//                       progressValue = (recentAttempt.totalAttempts! /
//                               recentAttempt.totalQuestions!.toDouble()) *
//                           1;
//                     } else {
//                       progressValue = 0;
//                     }

//                     if (kDebugMode) {
//                       print('Progress value: $progressValue');
//                     }

//                     return RecentActivityCard(
//                       acivityname: recentAttempt.deckName,
//                       date: recentAttempt.attemptedDate.toString(),
//                       progressValue: progressValue
//                           .toDouble(), // Convert to int before passing
//                     );
//                   },
//                 ),
//               ),

//               Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Card(
//                   elevation: 5,
//                   child: Container(
//                     width: 400,
//                     height: 240,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 10),
//                       child: FutureBuilder(
//                         future: userStatProvider.fetchUserStatistics(),
//                         builder: (context, snapshot) {
//                           if (snapshot.hasError) {
//                             return Text('Error: ${snapshot.error}');
//                           } else {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.done) {
//                               userStatModel = userStatProvider.userStatModel!;
//                               return Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10),
//                                         child: Image.asset(
//                                           PremedAssets.graph,
//                                           width: 60,
//                                           height: 60,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 10, left: 10, bottom: 7),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Statistics",
//                                               style: GoogleFonts.rubik(
//                                                 fontWeight: FontWeight.w800,
//                                                 fontSize: 18,
//                                               ),
//                                             ),
//                                             Text(
//                                               "Check out your performance at a glance!",
//                                               style: GoogleFonts.rubik(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 11,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 18,
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.of(context).push(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const StatisticsScreen()));
//                                         },
//                                         child: SvgPicture.asset(
//                                           PremedAssets.arrow,
//                                           width: 12,
//                                           height: 25,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(7.0),
//                                     child: Card(
//                                       elevation: 5,
//                                       child: Container(
//                                         height: 130,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Color.fromARGB(
//                                                       255, 180, 180, 180)
//                                                   .withOpacity(0.1),
//                                               spreadRadius: 2,
//                                               blurRadius: 5,
//                                               offset: const Offset(0, 3),
//                                             ),
//                                           ],
//                                         ),
//                                         child: MaterialCard(
//                                           height: 128,
//                                           width: 400,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   StatDetailHolder(
//                                                     textColor:
//                                                         const Color(0xFF60CDBB),
//                                                     count: userStatModel
//                                                         .decksAttempted,
//                                                     details: 'Decks\nAttempted',
//                                                   ),
//                                                   StatDetailHolder(
//                                                     textColor:
//                                                         const Color(0xFFEC5863),
//                                                     count: userStatModel
//                                                         .testAttempted,
//                                                     details: 'Test\nAttempted',
//                                                   ),
//                                                   StatDetailHolder(
//                                                     textColor:
//                                                         const Color(0xFFFFC372),
//                                                     count: userStatModel
//                                                         .paracticeTestAttempted,
//                                                     details:
//                                                         'Practice Tests\nAttempted',
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             } else {
//                               return Container(); // or any other widget you want to display while data is loading
//                             }
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/new_home_page/widgets/Flash_card.dart';
import 'package:premedpk_mobile_app/UI/screens/new_home_page/widgets/Qbank_card.dart';
import 'package:premedpk_mobile_app/UI/screens/new_home_page/widgets/notes_card.dart';
import 'package:premedpk_mobile_app/UI/screens/new_home_page/widgets/series_card.dart';
import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/question_of_day_card.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/recentActivityCard.dart';
import 'package:premedpk_mobile_app/UI/screens/notifications/notification_page.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/mdcat/mocks&bank_statistics.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/statistics_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/Attempted_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/card_w.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/recent_attempts_model.dart';
import 'package:premedpk_mobile_app/models/statistic_model.dart';
import 'package:premedpk_mobile_app/providers/recent_atempts_provider.dart';
import 'package:premedpk_mobile_app/providers/statistic_provider.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              // Added SizedBox here
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
                            return Text(
                              'Hi, ${userProvider.getUserName()}',
                              style: PreMedTextTheme().heading4.copyWith(
                                  fontWeight: FontWeight.w800, fontSize: 28),
                            );
                          },
                        ),
                        Text(
                          'Ready to continue your journey?',
                          style: PreMedTextTheme().body.copyWith(fontSize: 17),
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
                      bgColor: Colors.white,
                      text: 'CONTINUE STUDYING',
                      text1: 'Hydrocarbons',
                      text2: 'STUDY NOTES',
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    SeriesCard(
                      bgColor: Colors.white,
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
                      bgColor: Colors.white,
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
                      bgColor: Colors.white,
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
              const QuestionCard(
                question:
                    'What is the other name of the magnetic field intensity?',
                tags: ['physics', 'Electromagnetism'],
                isResource: false,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Consumer<RecentAttemptsProvider>(
                  builder: (context, recentAttemptsProvider, child) {
                    if (kDebugMode) {
                      print(
                          'Recent attempts: ${recentAttemptsProvider.recentAttempts.length}');
                    }

                    RecentAttempt recentAttempt =
                        recentAttemptsProvider.recentAttempts.isNotEmpty
                            ? recentAttemptsProvider.recentAttempts.first
                            : RecentAttempt(
                                deckName: '',
                                attemptedDate: DateTime.now(),
                                totalAttempts: 0,
                                totalQuestions: 0);

                    if (kDebugMode) {
                      print('Recent attempt: $recentAttempt');
                    }

                    double progressValue;
                    if (recentAttempt.totalAttempts != null &&
                        recentAttempt.totalQuestions != null &&
                        recentAttempt.totalQuestions! > 0) {
                      progressValue = (recentAttempt.totalAttempts! /
                              recentAttempt.totalQuestions!.toDouble()) *
                          1;
                    } else {
                      progressValue = 0;
                    }

                    if (kDebugMode) {
                      print('Progress value: $progressValue');
                    }

                    return RecentActivityCard(
                      acivityname: recentAttempt.deckName,
                      date: recentAttempt.attemptedDate.toString(),
                      progressValue: progressValue
                          .toDouble(), // Convert to int before passing
                    );
                  },
                ),
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
                      color: Colors.white,
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
                                        child: SvgPicture.asset(
                                          PremedAssets.arrow,
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
                                                        const Color(0xFF60CDBB),
                                                    count: userStatModel
                                                        .decksAttempted,
                                                    details: 'Decks\nAttempted',
                                                  ),
                                                  StatDetailHolder(
                                                    textColor:
                                                        const Color(0xFFEC5863),
                                                    count: userStatModel
                                                        .testAttempted,
                                                    details: 'Test\nAttempted',
                                                  ),
                                                  StatDetailHolder(
                                                    textColor:
                                                        const Color(0xFFFFC372),
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
                              return Container(); // or any other widget you want to display while data is loading
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
