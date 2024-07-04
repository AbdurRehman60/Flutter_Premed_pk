import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'entry_test.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  void _navigateToEntryTest(BuildContext context, String lastOnboardingPage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EntryTest(lastOnboardingPage: lastOnboardingPage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToEntryTest(context, "auth/onboarding/high-school");
              },
              child: Stack(
                children: [
                  ColoredBox(
                    color: PreMedColorTheme().highschoolblue,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I AM IN ',
                            style: PreMedTextTheme().heading3.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: PreMedColorTheme().white,
                            ),
                          ),
                          Text(
                            'HIGH SCHOOL',
                            style: PreMedTextTheme().heading3.copyWith(
                              fontSize: 45,
                              fontWeight: FontWeight.w800,
                              color: PreMedColorTheme().white,
                            ),
                          ),
                          SizedBoxes.verticalMedium,
                          Text(
                            'CLICK TO CONTINUE',
                            style: PreMedTextTheme().heading3.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: PreMedColorTheme().white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 32,
                    left: 8,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Material(
                        elevation: 4,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: 37,
                          height: 37,
                          child: SvgPicture.asset(
                            'assets/icons/left-arrow.svg',
                            width: 9.33,
                            height: 18.67,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToEntryTest(context, "auth/onboarding/entrance-exam");
              },
              child: ColoredBox(
                color: PreMedColorTheme().primaryColorRed,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I AM PREPARING FOR AN ',
                        style: PreMedTextTheme().heading3.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                      Text(
                        'ENTRY TEST',
                        style: PreMedTextTheme().heading3.copyWith(
                          fontSize: 45,
                          fontWeight: FontWeight.w800,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                      SizedBoxes.verticalMedium,
                      Text(
                        'CLICK TO CONTINUE',
                        style: PreMedTextTheme().heading3.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToEntryTest(context, "auth/onboarding/undergrad");
              },
              child: ColoredBox(
                color: PreMedColorTheme().customCheckboxColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I AM AN ',
                        style: PreMedTextTheme().heading3.copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                      Text(
                        'UNDERGRAD',
                        style: PreMedTextTheme().heading3.copyWith(
                          fontSize: 45,
                          fontWeight: FontWeight.w800,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                      SizedBoxes.verticalMedium,
                      Text(
                        'CLICK TO CONTINUE',
                        style: PreMedTextTheme().heading3.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: PreMedColorTheme().white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
