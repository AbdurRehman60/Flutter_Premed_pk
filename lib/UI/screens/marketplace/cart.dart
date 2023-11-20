import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/card_content.dart';
import 'package:premedpk_mobile_app/UI/screens/marketplace/widgets/countdown_timer.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/bundle_model.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider =
        ModalRoute.of(context)!.settings.arguments as CartProvider;
    CartProvider cartprovider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        centerTitle: true,
        title: Text(
          'Cart',
          style: PreMedTextTheme().subtext.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CountdownTimerWidget(),
            SizedBoxes.verticalMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: PreMedTextTheme().heading4,
                  ),
                  SizedBoxes.verticalLarge,
                  Container(
                    width: double.infinity,
                    height: 600,
                    decoration: BoxDecoration(
                      color: PreMedColorTheme().white,
                      border: GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [
                              PreMedColorTheme().primaryColorBlue,
                              PreMedColorTheme().primaryColorRed,
                            ],
                          ),
                          width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: cartProvider.selectedBundles.length,
                        separatorBuilder: (context, index) => Divider(
                          color: PreMedColorTheme().neutral300,
                        ), // Add a divider between items
                        itemBuilder: (context, index) {
                          BundleModel bundle =
                              cartProvider.selectedBundles[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CardContent(
                                    bundle: bundle,
                                    renderPoints: true,
                                    renderDescription: false,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close_rounded),
                                  onPressed: () {
                                    cartprovider.removeFromCart(bundle);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBoxes.verticalMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      const Expanded(
                        flex: 3,
                        child: CustomTextField(
                          hintText: 'Enter Code',
                        ),
                      ),
                      SizedBoxes.horizontalTiny,
                      Expanded(
                        child: CustomButton(
                          buttonText: 'Apply',
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBoxes.verticalMedium,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: PreMedColorTheme().white,
                  border: Border.all(
                    color: PreMedColorTheme().neutral300,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cart Summary',
                        style: PreMedTextTheme().body.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBoxes.verticalTiny,
                      Text(
                        'Subtotal: Rs. ${cartProvider.totalOriginalPrice.toStringAsFixed(2)}',
                        style: PreMedTextTheme().body.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBoxes.verticalTiny,
                      Text(
                        'Discount (50% off) -Rs.${cartProvider.calculateTotalDiscount}',
                        style: PreMedTextTheme().body.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBoxes.verticalTiny,
                      Text(
                        'Coupon',
                        style: PreMedTextTheme().body.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBoxes.verticalTiny,
                      SizedBox(
                        width: 280,
                        child: Divider(
                          color: PreMedColorTheme().neutral200,
                        ),
                      ),
                      Text(
                        'Total',
                        style: PreMedTextTheme().heading5,
                      ),
                      Row(
                        children: [
                          Text('Rs. ${cartProvider.totalDiscountedPrice}',
                              style: PreMedTextTheme().heading3.copyWith(
                                    color: PreMedColorTheme().primaryColorRed,
                                  )),
                          SizedBoxes.horizontalMedium,
                          Text(
                            'Rs. ${cartProvider.totalOriginalPrice}',
                            style: PreMedTextTheme().heading7.copyWith(
                                  color: PreMedColorTheme().neutral400,
                                  decoration: TextDecoration.lineThrough,
                                ),
                          ),
                        ],
                      ),
                      SizedBoxes.verticalLarge,
                      CustomButton(
                        buttonText: 'Proceed to checkout ->',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBoxes.verticalMedium,
          ],
        ),
      ),
      // bottomSheet: Container(
      //   height: MediaQuery.of(context).size.height * 0.35,
      //   decoration: BoxDecoration(
      //     color: PreMedColorTheme().white,
      //     borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(20.0),
      //       topRight: Radius.circular(20.0),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.1),
      //         blurRadius: 10.0,
      //         spreadRadius: 2.0,
      //         offset: const Offset(0, -1), // Offset to give a top shadow effect
      //       ),
      //     ],
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           'Cart Summary',
      //           style: PreMedTextTheme().body.copyWith(
      //                 fontWeight: FontWeight.bold,
      //               ),
      //         ),
      //         SizedBoxes.verticalTiny,
      //         Text(
      //           'Subtotal: Rs. ${cartProvider.totalOriginalPrice.toStringAsFixed(2)}',
      //           style: PreMedTextTheme().body.copyWith(
      //                 fontWeight: FontWeight.w500,
      //               ),
      //         ),
      //         SizedBoxes.verticalTiny,
      //         Text(
      //           'Discount (50% off) -Rs.${cartProvider.calculateTotalDiscount}',
      //           style: PreMedTextTheme().body.copyWith(
      //                 fontWeight: FontWeight.w500,
      //               ),
      //         ),
      //         SizedBoxes.verticalTiny,
      //         Text(
      //           'Coupon',
      //           style: PreMedTextTheme().body.copyWith(
      //                 fontWeight: FontWeight.w500,
      //               ),
      //         ),
      //         SizedBoxes.verticalTiny,
      //         SizedBox(
      //           width: 280,
      //           child: Divider(
      //             color: PreMedColorTheme().neutral200,
      //           ),
      //         ),
      //         Text(
      //           'Total',
      //           style: PreMedTextTheme().heading5,
      //         ),
      //         Row(
      //           children: [
      //             Text(
      //               'Rs. ${cartProvider.totalDiscountedPrice}',
      //               style: PreMedTextTheme().heading3.copyWith(
      //                     color: PreMedColorTheme().primaryColorRed,
      //                   ),
      //             ),
      //             SizedBoxes.horizontalMedium,
      //             Text(
      //               'Rs. ${cartProvider.totalOriginalPrice}',
      //               style: PreMedTextTheme().heading7.copyWith(
      //                     color: PreMedColorTheme().neutral400,
      //                     decoration: TextDecoration.lineThrough,
      //                   ),
      //             ),
      //           ],
      //         ),
      //         SizedBoxes.verticalLarge,
      //         CustomButton(
      //           buttonText: 'Proceed to checkout ->',
      //           onPressed: () {},
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
