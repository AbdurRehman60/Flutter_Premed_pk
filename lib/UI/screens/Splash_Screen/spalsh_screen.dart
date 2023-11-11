import 'dart:async'; // Import for Future.delayed
import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 4 seconds and then navigate to the login page
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
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

// ignore: camel_case_types

