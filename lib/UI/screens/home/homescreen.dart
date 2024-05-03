import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notes_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notifications_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/provincialguides/provincial_guides.dart';
import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/UI/test_interface/test_interface_page.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/decks_provider.dart';
import 'package:premedpk_mobile_app/providers/questions_proivder.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../global_qbank/qbank_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QbankHome()));
                                // final pro =
                                //     Provider.of<QuestionsProvider>(context,listen: false);
                                // pro.fetchQuestions();
                              },
                              child: Text(
                                "👋🏼 Welcome Back",
                                style: PreMedTextTheme().subtext,
                              ),
                            ),
                            SizedBoxes.vertical2Px,
                            Text(
                              userProvider.getUserName().split(' ').length > 1
                                  ? '${userProvider.getUserName().split(' ').first} ${userProvider.getUserName().split(' ')[1]}'
                                  : userProvider.getUserName().split(' ').first,
                              style: PreMedTextTheme().heading4,
                            ),
                          ],
                        ),
                        const NotificationIcon()
                      ],
                    ),
                    SizedBoxes.verticalLarge,
                    NotesTile(
                      heading: "Revision Notes",
                      description:
                          "Comprehensive study notes for Biology, Chemistry, Physics, and Mathematics, specifically designed to help you excel in your MDCAT exams.",
                      icon: PremedAssets.RevisionNotes,
                      bgColor: PreMedColorTheme().primaryColorRed100,
                      btnColor: PreMedColorTheme().primaryColorRed,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RevisionNotes(),
                          ),
                        );
                      },
                    ),
                    SizedBoxes.verticalMedium,
                    NotesTile(
                      heading: "Chapter Guides",
                      description:
                          "Comprehensive study guides for Biology, Chemistry, and Physics, specifically designed to help you in your MDCAT, NUMS and Private University exams.",
                      icon: PremedAssets.ProvisionalGuides,
                      bgColor: PreMedColorTheme().primaryColorBlue100,
                      btnColor: PreMedColorTheme().primaryColorBlue,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProvincialGuides(),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
