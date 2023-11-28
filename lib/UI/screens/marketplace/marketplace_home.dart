import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_drawer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_icon.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/marketplace_tabview.dart';

import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/special_offers_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../constants/constants_export.dart';

class MarketPlace extends StatelessWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBoxes.verticalMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBoxes.horizontalTiny,
                      SizedBoxes.horizontalTiny,
                      Center(
                        child: GradientText(
                          'PreMed.PK Bundles',
                          style: PreMedTextTheme().heading3,
                          colors: [
                            PreMedColorTheme().primaryColorBlue,
                            PreMedColorTheme().primaryColorRed,
                          ],
                        ),
                      ),
                      Builder(
                        builder: (BuildContext context) {
                          return TextButton(
                            onPressed: () {
                              // Open the endDrawer
                              Scaffold.of(context).openEndDrawer();
                            },
                            child: const CartIcon(),
                          );
                        },
                      )
                    ],
                  ),
                  SizedBoxes.verticalMedium,
                  CountdownTimerWidget(),
                  SizedBoxes.verticalBig,
                  const SpecialOffers(),
                  SizedBoxes.verticalBig,
                ],
              ),
            ),
            const MarketplaceTabView(),
          ],
        ),
      ),
      endDrawer: CartDrawer(),
    );
  }
}
