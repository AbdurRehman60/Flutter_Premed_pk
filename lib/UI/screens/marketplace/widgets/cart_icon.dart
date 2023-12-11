import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            PremedAssets.Cart,
            width: 30,
            height: 31,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              final int itemCount = cartProvider.totalBundlesCount;
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red, // or any other color you prefer
                  shape: BoxShape.circle,
                ),
                child: Text(itemCount > 0 ? itemCount.toString() : '0',
                    style: PreMedTextTheme().subtext1.copyWith(
                          fontSize: 12,
                          color: PreMedColorTheme().white,
                        )),
              );
            },
          ),
        ),
      ],
    );
  }
}
