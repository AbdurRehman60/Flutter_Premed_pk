import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notes_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notifications_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/provincialguides/provincial_guides.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/nums/mocks_or_bank.dart';
import 'package:premedpk_mobile_app/UI/screens/qbank/private_universities/pu_mock_or_bank_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../qbank/mdcat/mocks&bank_statistics.dart';

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
                            SizedBoxes.vertical2Px,
                            Text(
                              'Hi, ${userProvider.getUserName().split(' ').length > 1 ? '${userProvider.getUserName().split(' ').first} ${userProvider.getUserName().split(' ')[1]}' : userProvider.getUserName().split(' ').first}',
                              style: PreMedTextTheme().heading4.copyWith(
                                  fontWeight: FontWeight.w800, fontSize: 28),
                            ),
                            Text(
                              'Ready to continue your journey?',
                              style:
                                  PreMedTextTheme().body.copyWith(fontSize: 17),
                            )
                          ],
                        ),
                        const NotificationIcon()
                      ],
                    ),
                    SizedBoxes.verticalLarge,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PUmockorBankStats(),
                                  ),
                                );
                              },
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                  ),
                                  margin: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Image.asset(PremedAssets.PU),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBoxes.horizontal24Px,
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const NumsorBankStats(),
                                  ),
                                );
                              },
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                  ),
                                  margin: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Image.asset(PremedAssets.NUMS),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBoxes.horizontal24Px,
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const MDcatMockorBankStats(),
                                  ),
                                );
                              },
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 101,
                                  height: 105,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                  ),
                                  margin: const EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Image.asset(PremedAssets.MDCAT),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Material(
                    //   elevation: 3,
                    //   borderRadius: BorderRadius.circular(15),
                    //   child: NotesTile(
                    //     heading: "The Question Bank",
                    //     description:
                    //     "Attempt over 50,000 Questions on our website to prepare for the MDCAT, AKU and NUMS exam. This feature will be launched on the app very soon.",
                    //     icon: PremedAssets.QuestionBank,
                    //     bgColor: PreMedColorTheme().white,
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //           builder: (context) => const MDcatMockorBankStats(),
                    //           ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    SizedBoxes.verticalMedium,
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: NotesTile(
                        heading: "Revision Notes",
                        description:
                            "Comprehensive study notes for Biology, Physics and Chemistry",
                        icon: PremedAssets.RevisionNotes,
                        bgColor: PreMedColorTheme().white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RevisionNotes(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBoxes.verticalMedium,
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: NotesTile(
                        heading: "Study Guides",
                        description:
                            "Comprehensive study guides for Biology, Physics and Chemistry",
                        icon: PremedAssets.ProvisionalGuides,
                        bgColor: PreMedColorTheme().white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ProvincialGuides(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBoxes.verticalMedium,
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: NotesTile(
                        heading: "Flashcards",
                        description: "Fast-paced Revision",
                        icon: PremedAssets.Flashcards,
                        bgColor: PreMedColorTheme().white,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const FlashcardHome(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBoxes.verticalMedium,
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(15),
                      child: NotesTile(
                        heading: "Youtube",
                        description: "Latest updates on \nMDCAT!",
                        icon: PremedAssets.Youtube,
                        bgColor: PreMedColorTheme().white,
                        onTap: () {
                          launchUrl(
                            mode: LaunchMode.inAppBrowserView,
                            Uri.parse("https://www.youtube.com/@premedpk"),
                          );
                        },
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
