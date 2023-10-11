import 'dart:async'; // Import for Future.delayed

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:premedpk_mobile_app/export.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay of 4 seconds and then navigate to the login page
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Login()), // Replace 'LoginPage' with the actual login page
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
                height: 300,
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
class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
