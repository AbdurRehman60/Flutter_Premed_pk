import 'package:premedpk_mobile_app/UI/screens/home/widgets/notes_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notifications_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/provincialguides/provincial_guides.dart';
import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                            Text(
                              "👋🏼 Welcome Back",
                              style: PreMedTextTheme().subtext,
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
                    SizedBoxes.verticalMedium,
                    NotesTile(
                      heading: "Attempt Questions",
                      description:
                          "Attempt over 50,000 Questions on our website to prepare for the MDCAT, AKU and NUMS exam. This feature will be launched on the app very soon.",
                      icon: PremedAssets.QA,
                      bgColor: Color.fromARGB(255, 93, 230, 98),
                      btnColor: Colors.green,
                      onTap: () async {
                        const url =
                            'https://premed.pk/decks/mdcat%20qbank'; // Replace with your YouTube channel URL
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    SizedBoxes.verticalMedium,
                    NotesTile(
                      heading: "Latest updates on the \nMDCAT!",
                      description:
                          "Visit our YouTube Channel to watch guidance videos made by seniors who have cracked their entrance exams and gotten admission into their dream universities! Make sure to subscribe to stay updated!",
                      icon: PremedAssets.YT,
                      bgColor: PreMedColorTheme().primaryColorRed300,
                      btnColor: PreMedColorTheme().primaryColorRed600,
                      onTap: () async {
                        const url =
                            'https://www.youtube.com/@premedpk'; // Replace with your YouTube channel URL
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    SizedBoxes.verticalMedium,
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
