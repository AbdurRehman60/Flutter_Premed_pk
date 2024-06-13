import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Recent_Activity/widgets/recent_activity.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/qbank_card.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/question_of_day_card.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/recentActivityCard.dart';
import 'package:premedpk_mobile_app/UI/screens/home_page/widgets/update_card.dart';
import 'package:premedpk_mobile_app/constants/assets.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';
import 'package:premedpk_mobile_app/models/recent_attempts_model.dart';
import 'package:premedpk_mobile_app/providers/recent_atempts_provider.dart';

import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFBF0F3),
        body: SafeArea(child: SingleChildScrollView(
          child: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.02), // 2% of screen height
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // 'Hi, ${userProvider.getUserName().split(' ').length > 1? '${userProvider.getUserName().split(' ').first} ${userProvider.getUserName().split(' ')[1]}' : userProvider.getUserName().split(' ').first}',
                          'Hi,Fateh',
                          style: PreMedTextTheme().heading4.copyWith(
                              fontWeight: FontWeight.w800, fontSize: 28),
                        ),
                        Text(
                          'Ready to continue your journey?',
                          style: PreMedTextTheme().body.copyWith(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height *
                          0.03, // 5% of screen height
                      left: 23,
                    ),
                    child: Row(
                      children: [
                        Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(20),
                          child: Qbank(
                            icon: PremedAssets.numsQbankLogo,
                            onTap: () {},
                            bgColor: PreMedColorTheme().white,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.05), // 3% of screen width
                        Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(20),
                          child: Qbank(
                            icon: PremedAssets.MDCATQbankLogo,
                            onTap: () {},
                            bgColor: PreMedColorTheme().white,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.05), // 3% of screen width
                        Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(20),
                          child: Qbank(
                            icon: PremedAssets.priQbankLogo,
                            onTap: () {},
                            bgColor: PreMedColorTheme().white,
                          ),
                        ),
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
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: const RecentActivityCard(
                        acivityname: "Alkyl Halides and Amines Past Paper",
                        date: "26th Feb 2024",
                        progressValue: 0.0),
                  ),
                  // Consumer<RecentAttemptsProvider>(
                  //   builder: (context, recentAttemptsProvider, child) {
                  //      {
                  //       RecentAttempt recentAttempt =
                  //           recentAttemptsProvider.recentAttempts.last;
                  //       return RecentActivityCard(
                  //         acivityname: recentAttempt.deckName,
                  //         date: recentAttempt.attemptedDate.toString(),
                  //         progressValue: (recentAttempt.totalAttempts! /
                  //                 recentAttempt.totalQuestions!.toDouble()) *
                  //             100,
                  //       );
                  //     }

                  //   },
                  // ),
                  const UpdateCard()
                ],
              );
            },
          ),
        )));
  }
}
