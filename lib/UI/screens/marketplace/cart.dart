import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/card_content.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        centerTitle: true,
        title: Text(
          'Cart',
          style: PreMedTextTheme().subtext.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
      ),
      body: Column(
        children: [
          CountdownTimerWidget(),
          Text('Order Summary'),
          Text('Coupon'),
          CustomTextField(),
          CustomButton(buttonText: 'Apply ->', onPressed: () {})
        ],
      ),
    );
  }
}
