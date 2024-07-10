import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/widgets/welcome_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
import 'package:premedpk_mobile_app/UI/screens/onboarding/required_onboarding.dart';

import 'package:premedpk_mobile_app/constants/constants_export.dart';
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
            checkIfOnboardingComplete().then((onboarding) {
              if (response['status']) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => onboarding
                        ? const MainNavigationScreen()
                        : const RequiredOnboarding(),
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

  Future<bool> checkIfOnboardingComplete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('onBoarding') &&
        (prefs.getBool('onBoarding') ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'animations/${index + 1}.json',
                height: 200,
                fit: BoxFit.cover,
                repeat: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
