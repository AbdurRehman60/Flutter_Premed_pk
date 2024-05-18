import 'package:premedpk_mobile_app/UI/screens/marketplace/cart.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/card_content.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/custom_button.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets/empty_state.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import '../../Login/login_screen_one.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);

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

  void showLoginPopup(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Login Required"),
            content: const Text("To use this feature, you need to log in."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:  Text("Cancel", style: PreMedTextTheme().body.copyWith(
                  color: PreMedColorTheme().primaryColorRed,

                ),),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignIn(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(PreMedColorTheme().primaryColorRed),
                  foregroundColor: MaterialStateProperty.all<Color>(PreMedColorTheme().white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text("Login"),
              )
            ],
          );
        },
      );
    }


  Future<bool> checkIfUserLoggedIn() async {
    final UserProvider userProvider = UserProvider();
    return userProvider.isLoggedIn();
  }

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
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
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
                      Icons.delete_outline_outlined,
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
            child: cartProvider.selectedBundles.isNotEmpty
                ? ListView.separated(
              itemCount: cartProvider.selectedBundles.length,
              separatorBuilder: (context, index) => SizedBox(
                width: double.infinity,
                child: Divider(
                  color: PreMedColorTheme().neutral300,
                ),
              ), // Add a divider between items
              itemBuilder: (context, index) {
                final BundleModel bundle =
                cartProvider.selectedBundles[index];
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CardContent(
                          bundle: bundle,
                          renderPoints: false,
                          renderDescription: false,
                          small: true,
                        ),
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
                );
              },
            )
                : EmptyState(
                displayImage: PremedAssets.EmptyCart,
                title: "YOUR CART IS EMPTY",
                body: ""),
          ),
          const SizedBox(
            width: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBoxes.verticalMicro,
              Text(
                  'Total',
                  style: PreMedTextTheme().heading5.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  )
              ),
              SizedBoxes.verticalMedium,
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Rs. ${cartProvider.afterDiscountPrice}',
                      style: PreMedTextTheme().heading3.copyWith(
                        color: PreMedColorTheme().primaryColorRed,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBoxes.horizontalMicro,
                  Text(
                    'Rs. ${cartProvider.totalOriginalPrice}',
                    style: PreMedTextTheme().heading7.copyWith(
                      color: PreMedColorTheme().neutral400,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
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
                    buttonText: 'Checkout                               ',
                    onPressed: () async {
                      final isLoggedIn = checkIfUserLoggedIn();
                      if (await isLoggedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Cart(),
                            settings: RouteSettings(arguments: cartProvider),
                          ),
                        );
                      }
                      else{
                        showLoginPopup(context);
                      }
                    },
                    isIconButton: true,
                    icon: Icons.arrow_forward_outlined,
                    leftIcon: false,
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
