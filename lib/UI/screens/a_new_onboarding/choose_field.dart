import 'package:flutter_svg/flutter_svg.dart';
import 'package:premedpk_mobile_app/UI/screens/a_new_onboarding/choose_exam.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseField extends StatefulWidget {
  const ChooseField(
      {required this.lastOnboardingPage, required this.password,
        required this.city,
        required this.phoneNumber,
        required this.institution,
        required this.educationSystem,
        super.key});

  final String lastOnboardingPage;
  final String password;
  final String educationSystem;
  final String city;
  final String phoneNumber;
  final String institution;


  @override
  State<ChooseField> createState() => _ChooseFieldState();
}

class _ChooseFieldState extends State<ChooseField> {
  void _navigateToExam(BuildContext context, String additionalPath) {
    final completePath = "${widget.lastOnboardingPage}$additionalPath";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseExam(
          lastOnboardingPage: completePath,
          category: 'pre-medical',
          password: widget.password, city: widget.city, phoneNumber: widget.phoneNumber, institution: widget.institution, educationSystem: widget.educationSystem,
        ),
      ),
    );
    print(completePath);
  }

  void _navigateToExamm(BuildContext context, String additionalPath) {
    final completePath = "${widget.lastOnboardingPage}$additionalPath";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseExam(
          lastOnboardingPage: completePath,
          category: 'pre-engineering',
          password: widget.password, city: widget.city, phoneNumber: widget.phoneNumber, institution: widget.institution, educationSystem: widget.educationSystem,
        ),
      ),
    );
    print(completePath);
  }

  void _showComingSoonPopup(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Coming Soon!"),
          content: const Text(
              "This is not available on the app yet. We are working to bring the experience to the app as well. You can check our website for this feature."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () async {
                const url = 'https://premed.pk/'; // Corrected URL
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url),
                      mode: LaunchMode
                          .externalApplication); // Opens the URL in the browser
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text("Visit Website"),
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
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    _navigateToExam(context, "/pre-medical");
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/left-arrow.svg',
                            width: 9.33,
                            height: 18.67,
                          ),
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
                _navigateToExamm(context, "/pre-engineering");
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
            child: GestureDetector(
              onTap: () {
                _showComingSoonPopup(context);
              },
              child: Stack(
                children: [
                  Container(
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
                                  'ALLIED HEALTH SCIENCES',
                                  style: PreMedTextTheme().heading3.copyWith(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w800,
                                        color: PreMedColorTheme()
                                            .customCheckboxColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -35,
                          child: Image.asset(
                            PremedAssets.AHScartoon,
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.6,
                          ),
                        ),
                      ],
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
