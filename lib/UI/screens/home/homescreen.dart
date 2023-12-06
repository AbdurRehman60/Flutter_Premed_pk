import 'package:premedpk_mobile_app/UI/screens/home/widgets/notes_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notifications_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/provincialguides/provincial_guides.dart';
import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👋🏼 Welcome Back",
                        style: PreMedTextTheme().subtext,
                      ),
                      SizedBoxes.vertical2Px,
                      Text(
                        "Ebrahim Baig",
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
                    "Comprehensive study guides for Biology, Chemistry, and Physics, specifically designed to help you in your MDCAT, NUMS and AKU exams.",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
