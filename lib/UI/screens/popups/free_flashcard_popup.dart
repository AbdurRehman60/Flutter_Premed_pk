import 'package:premedpk_mobile_app/UI/screens/popups/timer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class FreeFlashcardPopUp extends StatelessWidget {
  const FreeFlashcardPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().primaryColorRedLighter,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: PreMedColorTheme().primaryColorRed,
              size: 34,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBoxes.verticalMedium,
            Text('🎉 Special Offer, Just for You! 🎉',
                textAlign: TextAlign.center,
                style: PreMedTextTheme().body.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: PreMedColorTheme().primaryColorRed)),
            SizedBoxes.verticalExtraGargangua,
            SizedBoxes.verticalExtraGargangua,
            Center(
              child:  RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: PreMedTextTheme().body.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: 'Flashcards',
                        style: PreMedTextTheme().body.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueAccent),
                      ),
                      TextSpan(
                        text: ', ',
                        style: PreMedTextTheme().body.copyWith(
                          fontSize: 24,
                          color: PreMedColorTheme().black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: 'Saved\nQuestions',
                        style: PreMedTextTheme().body.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueAccent),
                      ),
                      TextSpan(
                        text: ', ',
                        style: PreMedTextTheme().body.copyWith(
                            fontSize: 24,
                            color: PreMedColorTheme().black,
                            fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text: 'Doubt Solve',
                        style: PreMedTextTheme().body.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueAccent),
                      ),
                      TextSpan(
                        text: '\nand so much more!',
                        style: PreMedTextTheme().body.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: PreMedColorTheme().black),
                      ),
                    ]),
              ),
            ),
            SizedBoxes.verticalExtraGargangua,
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: PreMedColorTheme().primaryColorRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                        color: PreMedColorTheme().primaryColorRed200,
                        width: 2),
                  ),
                ),
                child: Text(
                  'Avail 70% Off Now',
                  style: PreMedTextTheme().body.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: PreMedColorTheme().white,
                  ),
                ),
              ),
            ),
            SizedBoxes.verticalExtraGargangua,
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: PreMedTextTheme().subtext.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.blueAccent),
                    children: [
                      TextSpan(text: 'The '),
                      TextSpan(
                          text: 'Offer ',
                          style: PreMedTextTheme().body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.blueAccent)),
                      TextSpan(text: 'Ends In')
                    ])),
            SizedBoxes.verticalMedium,
            const TimerWidget(),
            SizedBoxes.verticalExtraGargangua,
            SizedBoxes.verticalExtraGargangua,
            Container(
              width: double.infinity,
              height: 30,
              color: PreMedColorTheme().customCheckboxColor,
              child: Center(
                  child: Text(
                    'LIMITED TIME ONLY',
                    textAlign: TextAlign.center,
                    style: PreMedTextTheme().body.copyWith(
                        color: PreMedColorTheme().tickcolor,
                        fontWeight: FontWeight.w900,
                        fontSize: 20),
                  )),
            ),
            SizedBoxes.verticalExtraGargangua,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'PreMed is offering many of its features for free from 19th May till 25th May. Terms and Conditions Apply.',
                textAlign: TextAlign.center,
                style: PreMedTextTheme().body.copyWith(color: PreMedColorTheme().neutral500),),
            )
          ],
        ),
      ),
    );
  }
}
