import 'package:premedpk_mobile_app/UI/screens/marketplace/cart.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/card_content.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '${cartProvider.totalBundlesCount} ',
                      style: TextStyle(
                        color: PreMedColorTheme().primaryColorRed,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: 'Courses in Cart',
                      style: PreMedTextTheme().heading5.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  cartProvider.clearCart();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: PreMedColorTheme().neutral400,
                      size: 16, // Set icon color
                    ),
                    Text(
                      'Clear Cart',
                      style: TextStyle(
                        color: PreMedColorTheme().neutral400,
                        fontSize: 14, // Set text color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBoxes.verticalMedium,
          SizedBox(
            width: double.infinity,
            child: Divider(
              color: PreMedColorTheme().neutral300,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: cartProvider.selectedBundles.length,
              separatorBuilder: (context, index) => SizedBox(
                width: double.infinity,
                child: Divider(
                  color: PreMedColorTheme().neutral300,
                ),
              ), // Add a divider between items
              itemBuilder: (context, index) {
                BundleModel bundle = cartProvider.selectedBundles[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CardContent(
                        bundle: bundle,
                        renderPoints: false,
                        renderDescription: false,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: PreMedColorTheme().neutral400,
                      ),
                      onPressed: () {
                        cartProvider.removeFromCart(bundle);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total',
                style: PreMedTextTheme().heading5,
              ),
              SizedBoxes.verticalMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs. ${cartProvider.afterDiscountPrice}',
                      style: PreMedTextTheme().heading3.copyWith(
                            color: PreMedColorTheme().primaryColorRed,
                          )),
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
              Visibility(
                visible: cartProvider.totalBundlesCount > 0,
                child: SizedBox(
                  height: 50,
                  child: CustomButton(
                    buttonText: 'Go to Cart ->',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Cart(),
                          settings: RouteSettings(arguments: cartProvider),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
