import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/utils/validators.dart';
import 'package:provider/provider.dart';

class CouponCodeTF extends StatefulWidget {
  const CouponCodeTF({super.key});

  @override
  State<CouponCodeTF> createState() => _CouponCodeTFState();
}

class _CouponCodeTFState extends State<CouponCodeTF> {
  @override
  void initState() {
    super.initState();
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    cartProvider.couponCode = "";
    cartProvider.couponAmount = 0;
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);

    final TextEditingController couponText = TextEditingController();

    void onApplyCouponPressed() {
      final form = formKey.currentState!;
      if (form.validate()) {
        final Future<Map<String, dynamic>> response =
            cartProvider.verifyCouponCode(
          couponText.text,
        );
        response.then(
          (response) {
            if (response['status']) {
            } else {
              showError(context, response);
            }
          },
        );
      }
    }

    void handleRemovePromoCode() {
      cartProvider.clearCoupon();
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Coupon',
            style: PreMedTextTheme().heading6.copyWith(
                  color: PreMedColorTheme().primaryColorRed,
                ),
          ),
          SizedBoxes.verticalTiny,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: CustomTextField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  hintText: 'Enter Code',
                  controller: couponText,
                  validator: (value) =>
                      validateIsNotEmpty(value, "Coupon Code"),
                ),
              ),
              SizedBoxes.horizontalTiny,
              Expanded(
                child: CustomButton(
                  buttonText: 'Apply',
                  onPressed: onApplyCouponPressed,
                  color: cartProvider.validatingStatus ==
                          CouponValidateStatus.validating
                      ? PreMedColorTheme().neutral200
                      : PreMedColorTheme().primaryColorRed,
                ),
              ),
            ],
          ),
          SizedBoxes.verticalMicro,
          if (cartProvider.couponCode.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Promo Code: ${cartProvider.couponCode} is applied",
                  style: PreMedTextTheme().subtext.copyWith(
                        color: PreMedColorTheme().neutral400,
                      ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  splashRadius: 16,
                  onPressed: handleRemovePromoCode,
                  icon: Icon(
                    Icons.close,
                    color: PreMedColorTheme().neutral400,
                    size: 20,
                  ),
                ),
              ],
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
