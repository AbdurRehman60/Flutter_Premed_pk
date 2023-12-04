import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/UI/screens/login/login.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

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
