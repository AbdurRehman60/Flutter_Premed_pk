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
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);

    final TextEditingController couponText = TextEditingController();

    void handleRemovePromoCode() {
      cartProvider.clearCoupon();
    }
    final formKey = GlobalKey<FormState>();

    void onApplyCouponPressed(String couponCode) {
      final form = formKey.currentState!;
      if (form.validate()) {
        handleRemovePromoCode();
        final Future<Map<String, dynamic>> response =
        cartProvider.verifyCouponCode(
          couponText.text,
        );
        response.then(
              (response) {
            if (response['status']) {
              // Coupon code verified successfully
            } else {
              showError(context, response);
            }
          },
        );
      }
    }



    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Coupon Code',
            style: PreMedTextTheme().heading6.copyWith(
              color: PreMedColorTheme().black,
            ),
          ),
          SizedBoxes.verticalTiny,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 4,
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(15),
                  child: TextFormField(
                    inputFormatters: [UpperCaseTextFormatter()],
                    controller: couponText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.percent,
                        color: PreMedColorTheme().primaryColorRed,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: PreMedColorTheme().primaryColorRed,
                        ),
                        onPressed: () {
                          couponText.clear();
                        },
                      ),
                    ),
                    onChanged: (text) {
                    },
                    validator: (value) =>
                        validateIsNotEmpty(value, "Coupon Code"),
                    onFieldSubmitted: onApplyCouponPressed,
                  ),
                ),
              ),
              SizedBoxes.horizontalTiny,
              if (cartProvider.validatingStatus ==
                  CouponValidateStatus.validating)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                  ),
                )
            ],
          ),
          SizedBoxes.verticalMicro,
          if (cartProvider.couponCode.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Promo Code: ${cartProvider.couponCode} is applied",
                    style: PreMedTextTheme().subtext.copyWith(
                      color: PreMedColorTheme().neutral400,
                    ),
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
