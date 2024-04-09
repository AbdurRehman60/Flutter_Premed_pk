import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/login/widgets/login_form.dart';
import 'package:premedpk_mobile_app/UI/widgets/freenotes_animation.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: PreMedColorTheme().white,
                ),
                child:
                    Image.asset('assets/images/chips.png', fit: BoxFit.cover),
              ),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
