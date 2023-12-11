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
        centerTitle: true,
        title: Text(
          'Cart',
          style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
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
                  Text(
                    'Order Summary',
                    style: PreMedTextTheme().heading4,
                  ),
                  SizedBoxes.verticalLarge,
                  Container(
                    width: double.infinity,
                    height: 400,
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
                                        icon: const Icon(Icons.close_rounded),
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.46,
          width: double.infinity,
          decoration: BoxDecoration(
            color: PreMedColorTheme().white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  const CouponCodeTF(),
                  SizedBoxes.verticalLarge,
                  const CartSummary(),
                  SizedBoxes.verticalLarge,
                  CustomButton(
                    buttonText: 'Proceed to checkout ->',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Checkout(),
                        ),
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
