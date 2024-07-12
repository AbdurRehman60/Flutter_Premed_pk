import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/widgets/welcome_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/widgets/onboarding_screen_one.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((_) {
      checkIfUserExists().then((userExists) {
        if (userExists) {
          final AuthProvider auth =
              Provider.of<AuthProvider>(context, listen: false);

          auth.getLoggedInUser().then((response) {
            checkOnboarding().then((onboardingResponse) {
              if (response['status']) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => onboardingResponse['message'] ==
                            'home'
                        ? const MainNavigationScreen()
                        : getOnboardingScreen(onboardingResponse['message']),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
              }
            });
          });
        } else {
          // User does not exist, navigate to login screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        }
      });
    });
  }

  Future<bool> checkIfUserExists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('isLoggedin') &&
        (prefs.getBool('isLoggedin') ?? false);
  }

  Future<Map<String, dynamic>> checkOnboarding() async {
    Map<String, dynamic> result;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('lastOnboardingPage')) {
        final lastOnboardingPage = prefs.getString('lastOnboardingPage');

        if (lastOnboardingPage == "/auth/onboarding") {
          result = {'status': true, 'message': "OnboardingOne"};
        } else if (lastOnboardingPage == "/auth/onboarding/entrance-exam") {
          result = {'status': true, 'message': "EntryTest"};
        } else if (lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-medical" ||
            lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-engineering") {
          result = {'status': true, 'message': "RequiredOnboarding"};
        } else if (lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-medical/features" ||
            lastOnboardingPage ==
                "/auth/onboarding/entrance-exam/pre-engineering/features") {
          result = {'status': true, 'message': "OptionalOnboarding"};
        } else if (lastOnboardingPage ==
            "/auth/onboarding/entrance-exam/pre-medical/features/additional-info") {
          result = {'status': true, 'message': "home"};
        } else {
          result = {'status': true, 'message': "unknown"};
        }
      } else {
        result = {'status': true, 'message': "home"};
      }
    } catch (e) {
      result = {
        'status': false,
        'message': "Error in fetching Onboarding Details: $e"
      };
    }

    return result;
  }

  Widget getOnboardingScreen(String message) {
    switch (message) {
      case "OnboardingOne":
        return const OnboardingOne();
      case "EntryTest":
        return const OnboardingOne();
      case "RequiredOnboarding":
        return const RequiredOnboarding();
      case "OptionalOnboarding":
        return const OnboardingOne();
      case "home":
      case "unknown":
      default:
        return const MainNavigationScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'animations/1.json',
          height: 200,
          fit: BoxFit.cover,
          repeat: true,
        ),
      ),
    );
  }
}
