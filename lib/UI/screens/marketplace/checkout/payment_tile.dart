import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/thankyou.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/upload_payment_image.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_summary.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:provider/provider.dart';

class PaymentTile extends StatelessWidget {
   PaymentTile({
    super.key,
    required this.selected,
    required this.paymentProvider,
    required this.image,
    required this.numbers,
    required this.onTap,
    required this.transferAmountText,
  });

  final bool selected;
  final String paymentProvider;
  final String image;
  final Map<String, dynamic> numbers;
  final VoidCallback onTap;
  final String transferAmountText;

  final TextEditingController transactionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);

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

    bool validateOrder() {
      if (UplaodImageProvider().uploadedImage == null) {
        cartProvider.errors = {
          "hasErrors": true,
          "error": "Please upload payment screenshot.",
        };
      } else {
        cartProvider.errors = {
          "hasErrors": false,
          "error": "No Errors",
        };
      }

      return !cartProvider.errors["hasErrors"];
    }

    void onPlaceOrder() {
      if (validateOrder()) {
        final String transactionId = transactionController.text;
        final Future<Map<String, dynamic>> response = cartProvider.placeOrder(transactionId);
        response.then(
          (response) {
            if (response['status']) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Thankyou(),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(8),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  content: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "🚀 Order Placed Successfully!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              showError(context, response);
            }
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(cartProvider.errors['error']),
            duration: const Duration(seconds: 2),
          ),
        );
      }
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
        if (selected) SizedBoxes.verticalBig else const SizedBox(),
        if (selected)
          Material(
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: PreMedColorTheme().white,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      image,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    SizedBoxes.verticalMedium,
                    Text(transferAmountText),
                    SizedBoxes.verticalMedium,
                    SelectableText(
                      numbers.entries
                          .map((entry) => '${entry.value} (${entry.key})\n')
                          .join(' '),
                    ),
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
                    SizedBoxes.verticalMedium,
                    Text(
                      'Enter your payment transaction ID (Optional)',
                      style: PreMedTextTheme()
                          .body
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    SizedBoxes.verticalMicro,
                    Text(
                      'Note: Entering transaction ID helps us accept your orders faster.',
                      style: PreMedTextTheme().body.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: PreMedColorTheme().neutral400),
                    ),
                    SizedBoxes.verticalMedium,
                    CustomTextField(
                      controller: transactionController,
                      hintText: 'Enter Transaction ID',
                      hintStyle: PreMedTextTheme()
                          .body
                          .copyWith(color: PreMedColorTheme().neutral400),
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
                        dashPattern: const [10, 10],
                        strokeWidth: 4,
                        child: const UploadPaymentImage(),
                      ),
                    ),
                    SizedBoxes.verticalExtraGargangua,
                    const CartSummary(),
                    SizedBoxes.verticalMedium,
                    if (cartProvider.orderStatus == OrderStatus.processing)
                      Column(
                        children: [
                          SizedBoxes.verticalMedium,
                          SizedBoxes.verticalMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                  )),
                              SizedBoxes.horizontalMedium,
                              const Text("Placing Order"),
                            ],
                          ),
                        ],
                      )
                    else
                      CustomButton(
                        buttonText: 'Place Order ->',
                        onPressed: onPlaceOrder,
                      ),
                  ],
                ),
              ),
            ),
          )
        else
          const SizedBox(),
        SizedBoxes.verticalBig,
      ],
    );
  }
}
