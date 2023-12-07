import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/UI/screens/login/login.dart';
import 'package:premedpk_mobile_app/UI/screens/navigation_screen/main_navigation_screen.dart';
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
    // Delayed for animation to complete, you can adjust the duration accordingly
    Future.delayed(const Duration(seconds: 4), () async {
      bool userExists = await checkIfUserExists();
      if (userExists) {
        AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

        final Future<Map<String, dynamic>> response = auth.getLoggedInUser();
        response.then(
          (response) {
            if (response['status']) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainNavigationScreen(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          },
        );
      } else {
        // User does not exist, navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    });
  }

  Future<bool> checkIfUserExists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('isLoggedin') &&
        prefs.getBool('isLoggedin') == true;
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
