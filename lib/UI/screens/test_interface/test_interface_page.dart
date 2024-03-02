import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/test_interface/widgets/material_button.dart';
import 'package:premedpk_mobile_app/UI/screens/test_interface/widgets/quiz_option_container.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class TestInterfacePage extends StatelessWidget {
  const TestInterfacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'QUESTION 38',
          style: GoogleFonts.rubik(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: const Color(0x40383838),
            height: 1.3,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Material(
            elevation: 4,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.hardEdge,
            child: const SizedBox(
              height: 37,
              width: 37,
              child: Icon(
                Icons.arrow_back_outlined,
                color: Color(0xFFEC5863),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 8),
            onPressed: () {},
            icon: Material(
              elevation: 4,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.hardEdge,
              child: const SizedBox(
                height: 37,
                width: 37,
                child: Icon(
                  Icons.arrow_forward_outlined,
                  color: Color(0xFFEC5863),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 10),
        child: Column(
          children: [
            Text(
              'Suppose a body is moving in a circular path with a uniform angular velocity. Due to what reason does it possess centripetal acceleration?',
              style: GoogleFonts.rubik(
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                  color: const Color(0xFF000000)),
            ),
            SizedBoxes.vertical15Px,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialOptionButton(
                  title: 'Save',
                  iconName: 'save',
                  color: Color(0xFFF96D28),
                ),
                MaterialOptionButton(
                  title: 'Elimination Tool',
                  iconName: 'elimination',
                  color: Color(0xFF0C5ABC),
                ),
                MaterialOptionButton(
                  title: 'Report',
                  iconName: 'alert',
                  color: Color(0xFFFFFFFF),
                  bgColor: Color(0xFFEC5863),
                ),
              ],
            ),
            SizedBoxes.vertical15Px,
            Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 4,
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 163,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: NetworkImage(
                          'https://o.quizlet.com/my0265R9LhJSZUCDFxho7w.png')),
                ),
              ),
            ),
            SizedBoxes.vertical15Px,
            const Column(
              children: [
                QuizOptionContainer(
                    optionNumber: 'A',
                    quizOptionDetails: 'Change in Linear Velocity'),
                QuizOptionContainer(
                    optionNumber: 'B',
                    quizOptionDetails: 'Change in Angular Velocity'),
                QuizOptionContainer(
                    optionNumber: 'C',
                    quizOptionDetails: 'No Centripetal Force Exists'),
                QuizOptionContainer(
                    optionNumber: 'D',
                    quizOptionDetails:
                        'Centripetal Forces exists and has no known cause'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
