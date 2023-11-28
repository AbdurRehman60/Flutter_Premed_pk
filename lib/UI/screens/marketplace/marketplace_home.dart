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
      appBar: AppBar(
        title: GradientText(
          'PreMed.PK Bundles',
          style: PreMedTextTheme().heading5,
          colors: [
            PreMedColorTheme().primaryColorBlue,
            PreMedColorTheme().primaryColorRed,
          ],
        ),
        actions: [
          Builder(
            builder: (BuildContext builderContext) => TextButton(
              onPressed: () {
                Scaffold.of(builderContext).openEndDrawer();
              },
              child: const CartIcon(),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
