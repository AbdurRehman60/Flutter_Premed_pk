import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/uploadImage.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_summary.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    super.key,
    required this.selected,
    required this.paymentProvider,
    required this.image,
    required this.numbers,
    required this.onTap,
  });

  final bool selected;
  final String paymentProvider;
  final String image;
  final Map<String, dynamic> numbers;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    void copyToClipboard(String text) {
      final cleanedText = text.replaceAll('-', '');

      Clipboard.setData(ClipboardData(text: cleanedText));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return Column(
      children: [
        Material(
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: selected
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().neutral400,
                width: 1.5,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 16,
                        offset: const Offset(0, 0),
                      ),
                    ]
                  : [],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              color: PreMedColorTheme().white,
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: onTap,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  selected ? Colors.white : Colors.transparent,
                              border: Border.all(
                                color: PreMedColorTheme().primaryColorRed,
                                width: 2.0,
                              ),
                            ),
                            child: selected
                                ? Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      width: 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: PreMedColorTheme()
                                              .primaryColorRed),
                                    ),
                                  )
                                : null,
                          ),
                          SizedBoxes.horizontalMedium,
                          Text(
                            paymentProvider,
                            style: PreMedTextTheme().heading7,
                          ),
                        ],
                      ),
                      Image.asset(
                        image,
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        selected ? SizedBoxes.verticalBig : const SizedBox(),
        selected
            ? Container(
                width: double.infinity,
                height: 880,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: PreMedColorTheme().neutral400,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        image,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      SizedBoxes.verticalMedium,
                      const Text(
                        'Transfer the amount to these accounts and upload the screenshot of the receipt',
                      ),
                      SizedBoxes.verticalMedium,
                      SelectableText(
                        numbers.entries
                            .map((entry) => '${entry.value} (${entry.key})')
                            .join(' '),
                      ),
                      SizedBoxes.verticalMedium,
                      SizedBox(
                        width: 72,
                        height: 32,
                        child: CustomButton(
                            buttonText: "Copy",
                            isIconButton: true,
                            isOutlined: true,
                            icon: Icons.copy,
                            textColor: PreMedColorTheme().neutral500,
                            iconSize: 12,
                            fontSize: 12,
                            onPressed: () {
                              if (numbers.isNotEmpty) {
                                final phoneNumber = numbers.entries.first.value;
                                copyToClipboard(phoneNumber);
                              }
                            }),
                      ),
                      SizedBoxes.verticalExtraGargangua,
                      SizedBox(
                        width: double.infinity,
                        height: 256,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          strokeCap: StrokeCap.round,
                          color: PreMedColorTheme().primaryColorBlue500,
                          dashPattern: [10, 10],
                          strokeWidth: 4,
                          child: const LocalImageDisplayCheckout(),
                        ),
                      ),
                      SizedBoxes.verticalExtraGargangua,
                      const CartSummary(),
                      SizedBoxes.verticalMedium,
                      CustomButton(
                        buttonText: 'Place Order ->',
                        onPressed: () {
                          // Access the CartProvider using Provider.of
                          CartProvider cartProvider =
                              Provider.of<CartProvider>(context, listen: false);

                          cartProvider.placeOrder('ddd@gmail.com');
                        },
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox(),
        SizedBoxes.verticalBig,
      ],
    );
  }
}
