// import 'package:flutter/material.dart';
// import 'package:pre_med_app/export.dart';
import 'package:premedpk_mobile_app/export.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(PremedAssets.PrMedLogo)),
              SizedBoxes.verticalBig,
              Text(
                'Welcome Back!',
                textAlign: TextAlign.left,
                style: PreMedTextTheme().heading4,
              ),
              SizedBoxes.verticalMicro,
              Text(
                'Ready Pursue Your Medical Dreams?',
                textAlign: TextAlign.left,
                style: PreMedTextTheme()
                    .subtext
                    .copyWith(color: PreMedColorTheme().neutral500),
              ),
              Text(
                'Sign in to Continue Your Journey.',
                textAlign: TextAlign.left,
                style: PreMedTextTheme()
                    .subtext
                    .copyWith(color: PreMedColorTheme().neutral500),
              ),
              SizedBoxes.verticalBig,
              const CustomTextField(
                labelText: 'Email',
                hintText: 'John.doe@gmail.com',
              ),
              SizedBoxes.verticalBig,
              const CustomTextField(
                  labelText: "Password",
                  hintText: "PASSWORD",
                  obscureText: true),
              SizedBoxes.verticalBig,
              CustomButton(
                  buttonText: 'Login',
                  onPressed: () {
                    print('Button Pressed');
                  }),
              SizedBoxes.verticalBig,

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(
                    color: PreMedColorTheme().black,
                    thickness: 5,
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Divider(
              //       color: PreMedColorTheme().black,
              //       thickness: 5,
              //     ),
              //     // const Text('OR'),
              //     // Divider(
              //     //   color: PreMedColorTheme().black,
              //     //   thickness: 2,
              //     // )
              //   ],
              // ),
              SizedBoxes.verticalLarge,
              // GoogleSignin(),
            ],
          ),
        ),
      ),
    ));
  }
}
