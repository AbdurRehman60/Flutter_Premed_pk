import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/checkout.dart';

import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/card_content.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_summary.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/coupon_code.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';

import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: PreMedColorTheme().primaryColorRed),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Overview',
              style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
            ),
            SizedBoxes.vertical2Px,
            Text(
                'CART',
                style: PreMedTextTheme().subtext.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: PreMedColorTheme().black,)
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: PreMedColorTheme().black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxes.verticalLarge,
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 320,
                      decoration: BoxDecoration(
                        color: PreMedColorTheme().white,
                        border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                PreMedColorTheme().primaryColorBlue,
                                PreMedColorTheme().primaryColorRed,
                              ],
                            ),
                            width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: cartProvider.selectedBundles.isNotEmpty
                            ? ListView.separated(
                          itemCount: cartProvider.selectedBundles.length,
                          separatorBuilder: (context, index) => Divider(
                            color: PreMedColorTheme().neutral300,
                          ),
                          itemBuilder: (context, index) {
                            final BundleModel bundle =
                            cartProvider.selectedBundles[index];
                            return Padding(
                              padding: index ==
                                  cartProvider.selectedBundles.length -
                                      1
                                  ? const EdgeInsets.fromLTRB(
                                  16, 16, 16, 96)
                                  : const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CardContent(
                                      bundle: bundle,
                                      renderPoints: true,
                                      renderDescription: false,
                                    ),
                                  ),
                                  IconButton(
                                    icon: ImageIcon(
                                      const AssetImage('assets/icons/add_circle_outline.png'),
                                      size: 16,
                                      color: PreMedColorTheme().neutral400,
                                    ),
                                    onPressed: () {
                                      cartProvider.removeFromCart(bundle);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                            : EmptyState(
                            displayImage: PremedAssets.EmptyCart,
                            title: "YOUR CART IS EMPTY",
                            body: ""),
                      ),
                    ),
                  ),
                  SizedBoxes.verticalLarge,
                  const CouponCodeTF(),
                  SizedBoxes.verticalLarge,
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: PreMedColorTheme().white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          ),
                        ],
                        //border: Border.all(color: Colors.white, width: 4, ),
                      ),
                      child: const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const CartSummary(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBoxes.verticalLarge,
            Center(
              child: SizedBox(
                width: 245,
                child: CustomButton(
                  buttonText: 'Proceed to Payment      ',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Checkout(),
                      ),
                    );
                  },
                  isIconButton: true,
                  icon: Icons.arrow_forward_outlined,
                  leftIcon: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
