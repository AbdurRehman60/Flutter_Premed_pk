import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Login/login.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';
class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key});

  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width * 0.7;

    return Center(
      child: SizedBox(
        width: buttonSize,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PreMedColorTheme().white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 3,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(Icons.mail_outline,
                      color: PreMedColorTheme().black,),
                      Expanded(
                        child: Text(
                          'Sign In with Email',
                          textAlign: TextAlign.center,
                          style: PreMedTextTheme().subtext,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
