import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'choose_field.dart';

class ChooseSchool extends StatefulWidget {
  const ChooseSchool({super.key, this.city, this.phoneNumber, this.institution, this.password });
  final String? city;
  final String? phoneNumber;
  final String? institution;
  final String? password;
  @override
  State<ChooseSchool> createState() => _ChooseSchoolState();
}

class _ChooseSchoolState extends State<ChooseSchool> {
  void _navigateToEntryTest(BuildContext context, String lastOnboardingPage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseField(lastOnboardingPage: lastOnboardingPage, password: widget.password,),
      ),
    );
  }

  Future<void> _showComingSoonPopup(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Coming Soon!"),
          content: const Text(
              "We are working on this, come back later for updates."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
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
                _showComingSoonPopup(context);
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
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: PreMedColorTheme().primaryColorRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'COMING SOON',
                            style: PreMedTextTheme().heading3.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: PreMedColorTheme().white,
                            ),
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
                _navigateToEntryTest(context, "auth/onboarding/flow/entrance-exam");  // Entry Test tapped
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
                _showComingSoonPopup(context);  // Undergrad tapped
              },
              child: Stack(
                children: [
                  ColoredBox(
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
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: PreMedColorTheme().primaryColorRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'COMING SOON',
                            style: PreMedTextTheme().heading3.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: PreMedColorTheme().white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
