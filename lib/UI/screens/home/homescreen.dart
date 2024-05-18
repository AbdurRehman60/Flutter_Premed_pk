import 'dart:async';
import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Signup/signup_screen_one.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notes_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notifications_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/popups/activate_freetrial.dart';

import 'package:premedpk_mobile_app/UI/screens/provincialguides/provincial_guides.dart';
import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../flashcards/flashcards_home.dart';
import '../popups/activate_freetrial.dart';
import '../popups/marketing_campaign_popup.dart';
import '../provincialguides/provincial_guides.dart';
import '../revision_notes/revision_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _showMarketingCampaignPopup();
    });
  }

  void _showMarketingCampaignPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MarketingCampaignPopup();
      },
    );
  }

  Future<bool> checkIfUserExists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('isLoggedin') &&
        (prefs.getBool('isLoggedin') ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().primaryColorRedLighter,
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
                            SizedBoxes.vertical2Px,
                            Text(
                              // 'Hi, ${userProvider.getUserName().split(' ').length > 1 ? '${userProvider.getUserName().split(' ').first} ${userProvider.getUserName().split(' ')[1]}' : userProvider.getUserName().split(' ').first}',
                              'Welcome,',
                              style: PreMedTextTheme().heading4.copyWith(
                                  fontWeight: FontWeight.w800, fontSize: 30),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: PreMedTextTheme()
                                      .body
                                      .copyWith(fontSize: 17),
                                  children: [
                                    TextSpan(
                                      text: 'To the ',
                                      style: PreMedTextTheme().body.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: 'Pre',
                                      style: PreMedTextTheme().body.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    TextSpan(
                                      text: 'M',
                                      style: PreMedTextTheme().body.copyWith(
                                          fontSize: 17,
                                          color: PreMedColorTheme()
                                              .primaryColorRed,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    TextSpan(
                                      text: 'ed',
                                      style: PreMedTextTheme().body.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    TextSpan(
                                      text: ' App',
                                      style: PreMedTextTheme().body.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ]),
                            )
                          ],
                        ),
                        const NotificationIcon()
                      ],
                    ),
                    SizedBoxes.verticalLarge,
                    const ActivateFreeTrial(),
                    SizedBoxes.verticalLarge,
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: PreMedColorTheme().white, width: 2)),
                        child: NotesTile(
                          heading: "The Question Bank",
                          description:
                          "QBank of MDCAT, NUMS and Private Universities.",
                          icon: PremedAssets.QuestionBank,
                          bgColor: PreMedColorTheme().neutral100,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Access the Question Bank"),
                                  content: const Text(
                                      "You'll be redirected to the web, Sign in and access the QBank."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        launchUrl(
                                          mode: LaunchMode.inAppBrowserView,
                                          Uri.parse(
                                              "https://premed.pk/dashboard"),
                                        );
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBoxes.verticalGargangua,
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const RevisionNotes(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 70,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: PreMedColorTheme().neutral100,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: PreMedColorTheme().white,
                                        width: 2)),
                                child: Row(
                                  children: [
                                    Image.asset(PremedAssets.RevisionNotes),
                                    SizedBox(width: 16),
                                    Text(
                                      "Revision\nNotes",
                                      style: PreMedTextTheme().body.copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize:
                                          16), // Adjust text style as needed
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBoxes.horizontal15Px,
                        Expanded(
                          child: Material(
                            elevation: 3,
                            borderRadius: BorderRadius.circular(15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProvincialGuides(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 70,
                                padding: EdgeInsets.all(
                                    16), // Adjust padding as needed
                                decoration: BoxDecoration(
                                    color: PreMedColorTheme().neutral100,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: PreMedColorTheme().white,
                                        width: 2)),
                                child: Row(
                                  children: [
                                    Image.asset(PremedAssets.ProvisionalGuides),
                                    SizedBox(width: 16),
                                    Text(
                                      "Study\nGuides",
                                      style: PreMedTextTheme().body.copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize:
                                          16), // Adjust text style as needed
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBoxes.verticalGargangua,
                    SizedBoxes.horizontal15Px,
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: PreMedColorTheme().white, width: 2)),
                        child: NotesTile(
                          heading: "Flashcards",
                          description: "Fast-paced Revision",
                          icon: PremedAssets.Flashcards,
                          bgColor: PreMedColorTheme().neutral100,
                          onTap: () async {
                            await checkIfUserExists()
                                ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                const FlashcardHome(),
                              ),
                            )
                                : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                        ),
                      ),
                    ),
                    SizedBoxes.verticalGargangua,
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: PreMedColorTheme().white, width: 2)),
                        child: NotesTile(
                          heading: "Youtube",
                          description: "Latest updates on \nMDCAT!",
                          icon: PremedAssets.Youtube,
                          bgColor: PreMedColorTheme().neutral100,
                          onTap: () {
                            launchUrl(
                              mode: LaunchMode.inAppBrowserView,
                              Uri.parse("https://www.youtube.com/@premedpk"),
                            );
                          },
                        ),
                      ),
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
