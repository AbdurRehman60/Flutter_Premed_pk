import 'package:premedpk_mobile_app/UI/screens/flashcards/flashcards_home.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notes_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/home/widgets/notifications_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_home.dart';
import 'package:premedpk_mobile_app/UI/screens/provincialguides/provincial_guides.dart';
import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MDCAT()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: PreMedColorTheme().white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: PreMedColorTheme().white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            width: 180,
                            height: 130,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    PremedAssets.QuestionBank,
                                    width: 34,
                                    height: 68,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('PREVIOUS ACTIVITY', style: PreMedTextTheme().body.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: PreMedColorTheme().neutral600
                                    )),
                                    Text('MDCAT', style: PreMedTextTheme().heading5.copyWith(fontSize: 18, color: PreMedColorTheme().black,fontWeight: FontWeight.w800,)),
                                    Text('QBank', style: TextStyle(fontSize: 16, color: PreMedColorTheme().black)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBoxes.horizontalMicro,
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const FlashcardHome()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: PreMedColorTheme().white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: PreMedColorTheme().white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            width: 180,
                            height: 130,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    PremedAssets.Flashcards,
                                    width: 38,
                                    height: 38,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Flashcards', style: PreMedTextTheme().heading5.copyWith(fontSize: 22, color: PreMedColorTheme().black,fontWeight: FontWeight.w800,)),
                                    Text('Fast-paced \n revision!', style: TextStyle(fontSize: 16, color: PreMedColorTheme().black)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBoxes.verticalLarge,
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
