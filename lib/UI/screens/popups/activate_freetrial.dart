import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:premedpk_mobile_app/UI/screens/Splash_Screen/timer.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class ActivateFreeTrial extends StatefulWidget {
  const ActivateFreeTrial({super.key});

  @override
  State<ActivateFreeTrial> createState() => _ActivateFreeTrialState();
}

class _ActivateFreeTrialState extends State<ActivateFreeTrial> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TimerWidget(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'FREE TRIAL WEEK',
                  style: PreMedTextThemeRubik().body.copyWith(
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
                          style: PreMedTextThemeRubik().body.copyWith(fontSize: 18),
                          children: [
                            TextSpan(
                              text: 'Pre',
                              style: PreMedTextThemeRubik().body.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: 'M',
                              style: PreMedTextThemeRubik().body.copyWith(
                                  fontSize: 18,
                                  color: PreMedColorTheme().primaryColorRed,
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: 'ed',
                              style: PreMedTextThemeRubik().body.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            const TextSpan(text: ' is'),
                            TextSpan(
                              text: ' FREE',
                              style: PreMedTextThemeRubik().body.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blueAccent),
                            ),
                            const TextSpan(text: ' for a few days!'),
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
                child: Text('Activate Your Trial Now!',
                    style: PreMedTextThemeRubik().body.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: PreMedColorTheme().primaryColorRed)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
