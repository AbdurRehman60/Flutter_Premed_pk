import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reset Your Password',
              style: PreMedTextTheme().heading3.copyWith(
                    color: PreMedColorTheme().primaryColorRed,
                  ),
            ),
            SizedBoxes.verticalMedium,
            Text(
              'Please provide the email address \nassociated with your PreMed.PK account.',
              style: PreMedTextTheme().body.copyWith(
                    color: PreMedColorTheme().neutral600,
                  ),
            ),
            SizedBoxes.verticalMedium,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 1.0, // Border thickness
                ),
                borderRadius: BorderRadius.circular(12.0), // Border radius
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('E-mail*'),
                  CustomTextField(
                    hintText: 'baig.ebrahim@gmail.com',
                  ),
                  SizedBoxes.verticalExtraGargangua,
                  // Assuming you have a CustomTextField widget
                  CustomButton(
                    buttonText: 'Reset Password',
                    onPressed: () {},
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
