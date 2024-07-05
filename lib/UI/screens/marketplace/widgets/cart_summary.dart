import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/discount_row.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBoxes.verticalTiny,
        DiscountRow(
          title: 'Subtotal',
          price: cartProvider.totalOriginalPrice,
        ),
        SizedBoxes.verticalTiny,
        DiscountRow(
          title: 'Discount',
          discountPercentage: (cartProvider.totalOriginalPrice -
                  cartProvider.afterDiscountPrice) /
              cartProvider.totalOriginalPrice,
          price:
              cartProvider.totalOriginalPrice - cartProvider.afterDiscountPrice,
        ),
        SizedBoxes.verticalTiny,
        DiscountRow(
          title: 'Coupon',
          discountPercentage: cartProvider.couponAmount,
          price: cartProvider.couponDiscount,
        ),
        SizedBoxes.verticalMedium,
        Text(
          'Total',
          style: PreMedTextTheme().heading5,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Rs. ${cartProvider.calculateTotalDiscount}',
              style: PreMedTextTheme().heading3.copyWith(
                    color: PreMedColorTheme().primaryColorRed,
                  ),
            ),
            SizedBoxes.horizontalMedium,
            Text(
              'Rs. ${cartProvider.totalOriginalPrice}',
              style: PreMedTextTheme().heading7.copyWith(
                    color: PreMedColorTheme().neutral400,
                    decoration: TextDecoration.lineThrough,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
