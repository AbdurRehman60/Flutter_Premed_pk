import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/notes_widget.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/qbanks_container.dart';
import 'package:premedpk_mobile_app/UI/screens/question_banks/widgets/question_of_day.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/question_of_day_model.dart';
import 'package:premedpk_mobile_app/providers/question_of_day_provider.dart';
import 'package:provider/provider.dart';

class QbankHomePage extends StatefulWidget {
  const QbankHomePage({super.key});

  @override
  State<QbankHomePage> createState() => _QbankHomePageState();
}

class _QbankHomePageState extends State<QbankHomePage> {
  late QuestionOfTheDayModel questionOfTheDay;
  @override
  Widget build(BuildContext context) {
    final questionOfDayProvider =
        Provider.of<QuestionOfTheDayProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Fateh!',
                  style: GoogleFonts.rubik(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF000000),
                    height: 1.3,
                  ),
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
                      questionOfTheDay = questionOfDayProvider.questionOfTheDay!;
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
                            Spacer(),
                            Text(
                              'View All',
                              style: GoogleFonts.rubik(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFEC5863),
                                height: 1.3,
                              ),
                            ),
                          ],
                        )
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
