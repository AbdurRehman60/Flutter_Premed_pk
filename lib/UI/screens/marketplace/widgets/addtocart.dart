import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/cart.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/card_content.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class AddtoCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Drawer(
      child: SafeArea(
        child: CartWidget(cartProvider: cartProvider),
      ),
    );
  }
}

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.cartProvider,
  });

  final CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: '${cartProvider.totalBundlesCount} ',
                    style: TextStyle(
                      color: PreMedColorTheme().primaryColorRed,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                      text: 'Courses in \nCart',
                      style: PreMedTextTheme().heading5),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                cartProvider.clearCart();
              },
              style: TextButton.styleFrom(
                primary:
                    PreMedColorTheme().neutral400, // Set text and icon color
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: PreMedColorTheme().neutral400, // Set icon color
                  ),
                  Text(
                    'Clear Cart',
                    style: TextStyle(
                      color: PreMedColorTheme().neutral400, // Set text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBoxes.verticalMedium,
        SizedBox(
          width: 270,
          child: Divider(
            color: PreMedColorTheme().neutral300,
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: cartProvider.selectedBundles.length,
            separatorBuilder: (context, index) => SizedBox(
              width: 260,
              child: Divider(
                color: PreMedColorTheme().neutral300,
              ),
            ), // Add a divider between items
            itemBuilder: (context, index) {
              BundleModel bundle = cartProvider.selectedBundles[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CardContent(
                        bundle: bundle,
                        renderPoints: false,
                        renderDescription: false,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close_rounded),
                      onPressed: () {
                        cartProvider.removeFromCart(bundle);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              Row(
                children: [
                  Text('Rs. ${cartProvider.totalDiscountedPrice}',
                      style: PreMedTextTheme().heading3.copyWith(
                            color: PreMedColorTheme().primaryColorRed,
                          )),
                  SizedBoxes.horizontalMedium,
                  Text(
                    'Rs. ${cartProvider.totalOriginalPrice}',
                    style: PreMedTextTheme().heading7.copyWith(
                          color: PreMedColorTheme().neutral400,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                ],
              ),
              SizedBoxes.verticalMedium,
              SizedBox(
                height: 50,
                child: CustomButton(
                  buttonText: 'Go to Cart ->',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(),
                        settings: RouteSettings(arguments: cartProvider),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
