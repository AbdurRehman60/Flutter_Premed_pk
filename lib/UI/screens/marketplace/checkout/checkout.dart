import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/checkout/payment_tile.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/cart_summary.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/cart_provider.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:provider/provider.dart';

final Map<String, dynamic> meezanNumbers = {
  'Fahad Niaz Sheikh': 'Account No: 99170105642737',
};

final Map<String, dynamic> easyPaisaNumbers = {
  'Khwaja Muhammed Haiyaan': '0331-2176647',
  'Fahd Niaz Shaikh': '0336-2542685',
};

final Map<String, dynamic> jazzCashNumbers = {
  'Khwaja Muhammed Haiyaan': '0331-2176647',
};

class Checkout extends StatefulWidget {
  const Checkout({
    super.key,
  });

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final RadioGroup<int> paymentRadioGroup = RadioGroup<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: PreMedTextTheme().heading6.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        centerTitle: true,
        backgroundColor: PreMedColorTheme().white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              PaymentTile(
                selected: paymentRadioGroup.selectedValue == 0,
                paymentProvider: "Bank Transfer",
                image: PremedAssets.Meezan,
                numbers: meezanNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 0
                        ? paymentRadioGroup.setSelectedValue(0)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              PaymentTile(
                selected: paymentRadioGroup.selectedValue == 1,
                paymentProvider: "Easy Paisa",
                image: PremedAssets.EasyPaisa,
                numbers: easyPaisaNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 1
                        ? paymentRadioGroup.setSelectedValue(1)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              PaymentTile(
                selected: paymentRadioGroup.selectedValue == 2,
                paymentProvider: "Jazz Cash",
                image: PremedAssets.JazzCash,
                numbers: jazzCashNumbers,
                onTap: () {
                  setState(() {
                    paymentRadioGroup.selectedValue != 2
                        ? paymentRadioGroup.setSelectedValue(2)
                        : paymentRadioGroup.setSelectedValue(-1);
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How to pay',
                        style: PreMedTextTheme().heading5,
                      ),
                      Text(
                        'Zoom-in to view',
                        style: PreMedTextTheme().headline.copyWith(
                            color: PreMedColorTheme().neutral400,
                            fontWeight: FontWeights.regular),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalMedium,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: PreMedColorTheme().neutral300,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(8.0),
                        minScale: 0.5,
                        maxScale: 4.0,
                        scaleEnabled: true,
                        child: Image.asset(
                          PremedAssets.HowtoPay,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RadioGroup<T> {
  T? _selectedValue;

  T? get selectedValue => _selectedValue;

  void setSelectedValue(T value) {
    _selectedValue = value;
  }
}


// void _showBottomSheet(
//       String optionText, String imagePath, String accountDetails) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBoxes.verticalMedium,
//               Image.asset(
//                 imagePath,
//                 width: 100,
//                 height: 60,
//                 fit: BoxFit.contain,
//               ),
//               const Text(
//                 'Transfer the amount to these accounts \nand upload the screenshot of the \nreceipt',
//               ),
//               Text(accountDetails),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 64, vertical: 20),
//                 child: SizedBox(
//                   width: 256,
//                   height: 200,
//                   child: DottedBorder(
//                     color: PreMedColorTheme().primaryColorBlue500,
//                     strokeWidth: 10,
//                     dashPattern: [15, 15],
//                     child: LocalImageDisplayCheckout(),
//                   ),
//                 ),
//               ),
//               SizedBoxes.verticalExtraGargangua,
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 280,
//                       child: Divider(
//                         color: PreMedColorTheme().neutral200,
//                       ),
//                     ),
//                     SizedBoxes.verticalMedium,
//                     CartSummary(),
//                     SizedBoxes.verticalMedium,
//                     CustomButton(
//                       buttonText: 'Place Order ->',
//                       onPressed: () {
//                         // Access the CartProvider using Provider.of
//                         CartProvider cartProvider =
//                             Provider.of<CartProvider>(context, listen: false);

//                         cartProvider.placeOrder('ddd@gmail.com');
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }


  // Widget buildListTile(
  //     String title, int value, String imagePath, String accountdetails) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedOption = value;
  //         _showBottomSheet(title, imagePath, accountdetails);
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Card(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0),
  //           side: BorderSide(
  //             color: selectedOption == value ? Colors.blue : Colors.black,
  //             width: 1.0,
  //           ),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(6.0),
  //           child: ListTile(
  //             title: Text(title),
  //             leading: Radio(
  //               visualDensity: VisualDensity.compact,
  //               activeColor: PreMedColorTheme().primaryColorRed,
  //               value: value,
  //               groupValue: selectedOption,
  //               onChanged: (int? newValue) {
  //                 setState(() {
  //                   selectedOption = newValue!;
  //                   _showBottomSheet(title, imagePath,
  //                       accountdetails); // Show the bottom sheet on radio button change
  //                 });
  //               },
  //             ),
  //             trailing: Image.asset(
  //               imagePath,
  //               width: 100,
  //               height: 60,
  //             ),
  //             visualDensity: const VisualDensity(horizontal: -4.0),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }