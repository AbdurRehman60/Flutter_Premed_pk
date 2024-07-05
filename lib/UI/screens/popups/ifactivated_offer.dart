import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:premedpk_mobile_app/UI/screens/popups/free_flashcard_popup.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FreeFlashcardPopUp(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: PreMedColorTheme().white,
          border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  PreMedColorTheme().primaryColorBlue,
                  PreMedColorTheme().primaryColorRed,
                ],
              ),
              width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'OFFER JUST FOR YOU',
                style: PreMedTextTheme().body.copyWith(
                    color: PreMedColorTheme().neutral400,
                    fontSize: 11,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        style: PreMedTextTheme().body.copyWith(fontSize: 17),
                        children: [
                          TextSpan(
                            text: 'Flashcards',
                            style: PreMedTextTheme().body.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.blueAccent),
                          ),
                          TextSpan(
                            text: ', ',
                            style: PreMedTextTheme().body.copyWith(
                                  fontSize: 17,
                                  color: PreMedColorTheme().black,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          TextSpan(
                            text: 'Saved Questions',
                            style: PreMedTextTheme().body.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.blueAccent),
                          ),
                          TextSpan(
                            text: ', ',
                            style: PreMedTextTheme().body.copyWith(
                                fontSize: 17,
                                color: PreMedColorTheme().black,
                                fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: '\nDoubt Solve',
                            style: PreMedTextTheme().body.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.blueAccent),
                          ),
                          TextSpan(
                            text: ' and so much\nmore!',
                            style: PreMedTextTheme().body.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: PreMedColorTheme().black),
                          ),
                        ]),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: PreMedColorTheme().primaryColorRed,
                  ),
                ],
              ),
            ),
            SizedBoxes.verticalMicro,
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: RichText(
                text: TextSpan(
                  style: PreMedTextTheme().body.copyWith(fontSize: 15),
                  children: [
                    const TextSpan(text: 'Buy '),
                    TextSpan(
                      text: 'Pre',
                      style: PreMedTextTheme()
                          .body
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text: 'M',
                      style: PreMedTextTheme().body.copyWith(
                          fontSize: 15,
                          color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.w800),
                    ),
                    TextSpan(
                      text: 'ed',
                      style: PreMedTextTheme()
                          .body
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    const TextSpan(text: ' plans on'),
                    TextSpan(
                      text: ' 70%',
                      style: PreMedTextTheme().body.copyWith(
                          fontSize: 15,
                          color: PreMedColorTheme().primaryColorRed,
                          fontWeight: FontWeight.w800),
                    ),
                    const TextSpan(text: ' off!'),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
