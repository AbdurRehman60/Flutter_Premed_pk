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
  final formKey = GlobalKey<FormState>();
  final TextEditingController referralText = TextEditingController();

  @override
  void initState() {
    super.initState();
    final CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.couponCode = "";
    cartProvider.couponAmount = 0;
  }

  void handleRemoveReferralCode() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.clearCoupon();
  }

  Future<void> onApplyReferralPressed(BuildContext parentContext) async {
    final form = formKey.currentState!;
    if (form.validate()) {
      handleRemoveReferralCode();
      final CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);

      try {
        final response = await cartProvider.verifyCouponCode(referralText.text);

        if (response['status']) {
          // Use the parent context to show the dialog
          if (mounted) {
            showDialog(
              context: parentContext,
              builder: (_) => AlertDialog(
                title: const Text("Success"),
                content: const Text("Referral code applied successfully!"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(parentContext).pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
            );
          }
        } else {
          showError(parentContext, response);
        }
      } catch (e) {
        showError(parentContext, {'error': e.toString()});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Referral Code',
            style: PreMedTextTheme().heading6.copyWith(
              color: PreMedColorTheme().primaryColorRed,
            ),
          ),
          SizedBoxes.verticalTiny,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 4,
                child: CustomTextField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  hintText: 'Enter Referral Code',
                  controller: referralText,
                  validator: (value) => validateIsNotEmpty(value, "Referral Code"),
                ),
              ),
              SizedBoxes.horizontalTiny,
              if (cartProvider.validatingStatus == CouponValidateStatus.validating)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                )
              else
                Expanded(
                  child: CustomButton(
                    buttonText: '→',
                    onPressed: () => onApplyReferralPressed(context),
                    color: PreMedColorTheme().primaryColorRed,
                  ),
                ),
            ],
          ),
          SizedBoxes.verticalMicro,
          if (cartProvider.couponCode.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Referral Code: ${cartProvider.couponCode} is applied",
                    style: PreMedTextTheme().subtext.copyWith(
                      color: PreMedColorTheme().neutral400,
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  splashRadius: 16,
                  onPressed: handleRemoveReferralCode,
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
