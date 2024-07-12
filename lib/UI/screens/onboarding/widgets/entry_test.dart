import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../../Signup/widgets/signup_screen_one.dart';

class EntryTest extends StatefulWidget {
  const EntryTest({required this.lastOnboardingPage, super.key});

  final String lastOnboardingPage;

  @override
  State<EntryTest> createState() => _EntryTestState();
}

class _EntryTestState extends State<EntryTest> {
  void _navigateToSignup(BuildContext context, String additionalPath) {
    final completePath = "${widget.lastOnboardingPage}$additionalPath";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(lastOnboardingPage: completePath),
      ),
    );
    print(completePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    _navigateToSignup(context, "/pre-medical");
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color(0xFFE4E9FD),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'I INTEND TO BE A',
                                style: PreMedTextTheme().heading3.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: PreMedColorTheme().black,
                                    ),
                              ),
                              Text(
                                'DOCTOR',
                                style: PreMedTextTheme().heading3.copyWith(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w800,
                                      color: PreMedColorTheme().primaryColorRed,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    PremedAssets.Doctor,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
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
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToSignup(context, "/pre-engineering");
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xFFE4E9FD),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I INTEND TO BE AN',
                              style: PreMedTextTheme().heading3.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: PreMedColorTheme().black,
                                  ),
                            ),
                            Text(
                              'ENGINEER',
                              style: PreMedTextTheme().heading3.copyWith(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                    color: PreMedColorTheme().highschoolblue,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 20,
                      child: Image.asset(
                        PremedAssets.Engineer,
                        width: MediaQuery.of(context).size.width * 0.48,
                        height: MediaQuery.of(context).size.width * 0.48,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Stack(children: [
            GestureDetector(
              onTap: () {
                _navigateToSignup(context, "/business-management");
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xFFE4E9FD),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I WANT TO JOIN',
                              style: PreMedTextTheme().heading3.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: PreMedColorTheme().black,
                                  ),
                            ),
                            Text(
                              'BUSINESS & MANAGEMENT',
                              style: PreMedTextTheme().heading3.copyWith(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        PreMedColorTheme().customCheckboxColor,
                                  ),
                            ),
                          ],
                        ),
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
                      borderRadius: BorderRadius.circular(12)),
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
          ])),
        ],
      ),
    );
  }
}
