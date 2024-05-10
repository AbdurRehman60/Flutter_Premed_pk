import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/recent_activity_page.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/flash_card_container.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/notes_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/notification_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/qbanks_container.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/question_of_day.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/recent_activity_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/question_of_day_model.dart';
import 'package:premedpk_mobile_app/providers/question_of_day_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/recent_activity_model.dart';
import '../../../providers/recent_activity_provider.dart';

class QbankHomePage extends StatelessWidget {
  const QbankHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    late QuestionOfTheDayModel questionOfTheDay;
    final recentActivityPro =
        Provider.of<RecentActivityProvider>(context, listen: false);
    final questionOfDayProvider =
        Provider.of<QuestionOfTheDayProvider>(context, listen: false);
    late List<RecentActivityModel> recentActivityList;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Rizz!',
                      style: GoogleFonts.rubik(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                    const NotificationIconWidget()
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'Ready to continue your journey?',
                  style: GoogleFonts.rubik(
                    fontSize: 17,
                    height: 1.3,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF000000),
                  ),
                ),
                SizedBoxes.verticalBig,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QbankFlashCardContainer(
                      icon: PremedAssets.DocumentIcon,
                      activityText: 'PREVIOUS ACTIVITY',
                      title: 'MDCAT',
                      subTitle: 'QBank',
                    ),
                    QbankFlashCardContainer(
                      icon: PremedAssets.FlashCardsIcon,
                      activityText: '',
                      title: 'Flashcards',
                      subTitle: 'Fast-paced revision!',
                    ),
                  ],
                ),
                SizedBoxes.verticalBig,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QbankContainerWidget(iconName: 'mdcatqbank'),
                    QbankContainerWidget(iconName: 'numsqbank'),
                    QbankContainerWidget(iconName: 'priuniqbank'),
                  ],
                ),
                SizedBoxes.verticalBig,
                const NotesContainerWidget(
                  iconName: 'revisionnotes',
                  title: 'Revision Notes',
                ),
                SizedBoxes.verticalBig,
                const NotesContainerWidget(
                  iconName: 'studyquide',
                  title: 'Study Guides',
                ),
                SizedBoxes.verticalBig,
                FutureBuilder(
                  future: questionOfDayProvider.fetchQuestion(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      ); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error fetching data'),
                      );
                    } else {
                      questionOfTheDay =
                          questionOfDayProvider.questionOfTheDay!;
                      return QuestionOfDay(question: questionOfTheDay);
                    }
                  },
                ),
                SizedBoxes.verticalBig,
                Material(
                  elevation: 1,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFF7F3F5),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'RECENT ACTIVITY',
                              style: GoogleFonts.rubik(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: const Color(0x59000000),
                                height: 1.3,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        const RecentActivityPage()));
                              },
                              child: Text(
                                'View All',
                                style: GoogleFonts.rubik(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFFEC5863),
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBoxes.vertical15Px,
                        FutureBuilder(
                          future: recentActivityPro.fetchRecentActivity(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return const Center(
                                child: Text('Error fetching data'),
                              );
                            } else {
                              recentActivityList =
                                  recentActivityPro.recentActivityList;
                              if (recentActivityList.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return RecentActivityWidget(
                                      topPadding: const EdgeInsets.only(top: 1),
                                      recent: recentActivityList.first,
                                      line: const SizedBox(
                                        height: 1,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text('No recent activity'),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
