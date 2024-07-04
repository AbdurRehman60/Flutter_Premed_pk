import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
import '../../Widgets/global_widgets/error_dialogue.dart';
import '../Login/login.dart';

class RequiredOnboarding extends StatefulWidget {
  const RequiredOnboarding({super.key});

  @override
  State<RequiredOnboarding> createState() => _RequiredOnboardingState();
}

class _RequiredOnboardingState extends State<RequiredOnboarding> {
  @override
  Widget build(BuildContext context) {
    final username = UserProvider().user?.fullName;
    final AuthProvider auth = Provider.of<AuthProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final String? lastob = userProvider.user?.info.lastOnboardingPage;
    final double screenWidth = MediaQuery.of(context).size.width;
    bool isTapped = false;

    final double containerWidth = screenWidth * 0.35;

    Future<void> onLogoutPressed() async {
      final Future<Map<String, dynamic>> response = auth.logout();

      response.then(
        (response) {
          if (response['status']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          } else {
            showError(context, response);
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: PreMedColorTheme().neutral60,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBoxes.verticalGargangua,
                            RichText(
                              text: TextSpan(
                                  style: PreMedTextTheme().subtext.copyWith(
                                      color: PreMedColorTheme().black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    const TextSpan(
                                      text: 'Hi, ',
                                    ),
                                    WidgetSpan(
                                      child: GradientText(
                                        text: username ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 35,
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[
                                            Colors.purple,
                                            PreMedColorTheme().primaryColorRed,
                                          ],
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '!',
                                      style: PreMedTextTheme()
                                          .subtext1
                                          .copyWith(
                                              color: PreMedColorTheme().black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 35),
                                    ),
                                  ]),
                            ),
                            SizedBoxes.verticalLarge,
                            RichText(
                              text: TextSpan(
                                  style: PreMedTextTheme().subtext.copyWith(
                                      color: PreMedColorTheme().black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    const TextSpan(
                                      text: 'What ',
                                    ),
                                    TextSpan(
                                        text: 'exam ',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 25,
                                                color: PreMedColorTheme()
                                                    .primaryColorRed)),
                                    TextSpan(
                                      text: 'are you preparing for?',
                                      style:
                                          PreMedTextTheme().subtext1.copyWith(
                                                color: PreMedColorTheme().black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 25,
                                              ),
                                    ),
                                  ]),
                            ),
                            SizedBoxes.verticalMicro,
                            Text(
                              'You can select more than one',
                              style: PreMedTextTheme().body.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            SizedBoxes.verticalLarge,
                            Row(
                              children: [
                                 GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isTapped = !isTapped;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0x80FFFFFF),
                                      border: Border.all(
                                        color: isTapped ? PreMedColorTheme().primaryColorRed : Colors.white,
                                        width: 6,
                                      ),
                                    ),
                                    width: containerWidth,
                                    height: 90,
                                    child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          lastob == 'auth/onboarding/entrance-exam/pre-medical'
                                              ? 'MDCAT'
                                              : 'FAST',
                                      style: PreMedTextTheme()
                                          .heading3
                                          .copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                              color: PreMedColorTheme()
                                                  .primaryColorRed),
                                    )),
                                  ),
                                ),
                                SizedBoxes.horizontal24Px,
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                      border: Border.all(
                                          color: Colors.white, width: 6)
                                  ),
                                  width: containerWidth,
                                  height: 90,
                                  child: Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    lastob ==
                                            'auth/onboarding/entrance-exam/pre-medical'
                                        ? 'NUMS'
                                        : 'NUST',
                                    style: PreMedTextTheme().heading3.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        color:
                                            PreMedColorTheme().primaryColorRed),
                                  )),
                                ),
                              ],
                            ),
                            SizedBoxes.verticalMedium,
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0x80FFFFFF),
                                      border: Border.all(
                                          color: Colors.white, width: 6)),
                                  width: containerWidth,
                                  height: 90,
                                  child: Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    lastob ==
                                            'auth/onboarding/entrance-exam/pre-medical'
                                        ? 'Private Universities'
                                        : 'GIKI',
                                    style: PreMedTextTheme().heading3.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        color:
                                            PreMedColorTheme().primaryColorRed),
                                  )),
                                ),
                                SizedBoxes.horizontal24Px,
                                if (lastob ==
                                    'auth/onboarding/entrance-exam/pre-engineering')
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0x80FFFFFF),
                                        border: Border.all(
                                            color: Colors.white, width: 6)),
                                    width: containerWidth,
                                    height: 90,
                                    child: Center(
                                        child: Text(
                                      textAlign: TextAlign.center,
                                      'UET',
                                      style: PreMedTextTheme()
                                          .heading3
                                          .copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 20,
                                              color: PreMedColorTheme()
                                                  .primaryColorRed),
                                    )),
                                  ),
                              ],
                            ),
                            SizedBoxes.verticalMedium,
                            if (lastob ==
                                'auth/onboarding/entrance-exam/pre-engineering')
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        color: Colors.white, width: 6)),
                                width: containerWidth,
                                height: 90,
                                child: Center(
                                    child: Text(
                                  textAlign: TextAlign.center,
                                  'NED',
                                  style: PreMedTextTheme().heading3.copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                      color:
                                          PreMedColorTheme().primaryColorRed),
                                )),
                              ),
                          ],
                        ),
                        SizedBoxes.verticalLarge,
                        RichText(
                          text: TextSpan(
                              style: PreMedTextTheme().subtext.copyWith(
                                  color: PreMedColorTheme().black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                              children: [
                                const TextSpan(
                                  text: 'What ',
                                ),
                                TextSpan(
                                    text: 'features ',
                                    style: PreMedTextTheme().heading3.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25,
                                        color:
                                            PreMedColorTheme().highschoolblue)),
                                TextSpan(
                                  text: 'do you want?',
                                  style: PreMedTextTheme().subtext1.copyWith(
                                        color: PreMedColorTheme().black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25,
                                      ),
                                ),
                              ]),
                        ),
                        SizedBoxes.verticalMicro,
                        Text(
                          'You can select more than one',
                          style: PreMedTextTheme().body.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBoxes.verticalLarge,
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Topicals',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            SizedBoxes.horizontal24Px,
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Yearly',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBoxes.verticalTiny,
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Revision Notes',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            SizedBoxes.horizontal24Px,
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Mnemonics',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBoxes.verticalTiny,
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Mocks',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            SizedBoxes.horizontal24Px,
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Statistics',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBoxes.verticalTiny,
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Guides',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            SizedBoxes.horizontal24Px,
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Recent Activity',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBoxes.verticalTiny,
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Expert's Solution",
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            SizedBoxes.horizontal24Px,
                            IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0x80FFFFFF),
                                    border: Border.all(
                                        width: 5, color: Colors.white)),
                                //width: containerWidth,
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        PremedAssets.Books,
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBoxes.horizontal10Px,
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Flashcards',
                                        style: PreMedTextTheme()
                                            .heading3
                                            .copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color:
                                                    PreMedColorTheme().black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBoxes.verticalTiny,
                        IntrinsicWidth(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0x80FFFFFF),
                                border:
                                    Border.all(width: 5, color: Colors.white)),
                            //width: containerWidth,
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    PremedAssets.Books,
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBoxes.horizontal10Px,
                                  Text(
                                    textAlign: TextAlign.center,
                                    'Recorded Lectures',
                                    style: PreMedTextTheme().heading3.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: PreMedColorTheme().black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // CustomButton(
                        //     buttonText: "go", onPressed: onLogoutPressed)
                      ]),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PreMedColorTheme().primaryColorRed200,
                          width: 6,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().neutral60,
                        radius: 20,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 28,
                          color: PreMedColorTheme().primaryColorRed,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Your action here
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: PreMedColorTheme().bordercolor,
                          width: 6,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().primaryColorRed,
                        radius: 28,
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
  });

  final String text;
  final TextStyle style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient
            .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
