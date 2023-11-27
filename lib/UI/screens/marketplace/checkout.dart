import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/local_image_display.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/video_player.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/bundle_provider.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  final double totalOriginalPrice;
  final double calculateTotalDiscount;
  final double totalDiscountedPrice;

  Checkout({
    required this.totalOriginalPrice,
    required this.calculateTotalDiscount,
    required this.totalDiscountedPrice,
  });

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int selectedOption = 0; // Initialize selectedOption to a default value
  String selectedImagePath = PremedAssets.HowtoPay;

  void _showBottomSheet(
      String optionText, String imagePath, String accountDetails) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBoxes.verticalMedium,
              Image.asset(
                imagePath,
                width: 100,
                height: 60,
                fit: BoxFit.contain,
              ),
              Text(
                'Transfer the amount to these accounts \nand upload the screenshot of the \nreceipt',
              ),
              Text(accountDetails),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 64, vertical: 20),
                    child: SizedBox(
                      width: 256,
                      height: 200,
                      child: DottedBorder(
                        color: PreMedColorTheme().primaryColorBlue500,
                        strokeWidth: 10,
                        dashPattern: [15, 15],
                        child: LocalImageDisplayCheckout(),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () {
                        // Update the selected image path
                        setState(() {
                          selectedImagePath = PremedAssets.HowtoPay;
                          Navigator.of(context).pop();
                        });
                      },
                      child: Icon(Icons.warning),
                    ),
                  ),
                  SizedBoxes.verticalExtraGargangua,
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      child: Divider(
                        color: PreMedColorTheme().neutral200,
                      ),
                    ),
                    SizedBoxes.verticalMedium,
                    Text(
                      'Subtotal: Rs. ${widget.totalOriginalPrice.toStringAsFixed(2)}',
                      style: PreMedTextTheme().body.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBoxes.verticalTiny,
                    Text(
                      'Discount (50% off) -Rs.${widget.calculateTotalDiscount}',
                      style: PreMedTextTheme().body.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      'Coupon (15% off) -Rs.${widget.calculateTotalDiscount}',
                      style: PreMedTextTheme().body.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBoxes.verticalMedium,
                    SizedBox(
                      width: 280,
                      child: Divider(
                        color: PreMedColorTheme().neutral200,
                      ),
                    ),
                    SizedBoxes.verticalMedium,
                    Text(
                      'Total',
                      style: PreMedTextTheme().heading5,
                    ),
                    SizedBoxes.verticalMedium,
                    Row(
                      children: [
                        Text(
                          'Rs. ${widget.totalDiscountedPrice}',
                          style: PreMedTextTheme().heading3.copyWith(
                                color: PreMedColorTheme().primaryColorRed,
                              ),
                        ),
                        SizedBoxes.horizontalMedium,
                        Text(
                          'Rs. ${widget.totalOriginalPrice}',
                          style: PreMedTextTheme().heading7.copyWith(
                                color: PreMedColorTheme().neutral400,
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                      ],
                    ),
                    SizedBoxes.verticalMedium,
                    CustomButton(
                      buttonText: 'Place Order ->',
                      onPressed: () {
                        // Access the CartProvider using Provider.of
                        CartProvider cartProvider =
                            Provider.of<CartProvider>(context, listen: false);

                        // Call the function to place the order
                        cartProvider.placeOrder('ddd@gmail.com');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
        child: Column(
          children: <Widget>[
            // Add your ListView with radio buttons
            buildListTile('Easypaisa', 1, 'assets/images/easypaisa.jpg',
                '0331-2176647 (Khwaja Muhammed  \n Haiyaan) \n0336-2542685 (Fahd Niaz Shaikh)'),
            buildListTile('Jazzcash', 2, 'assets/images/jazzcash.png',
                '0331-2176647 (Khwaja Muhammed \n Haiyaan)'),
            buildListTile('Banktransfer', 3, 'assets/images/meezan.jpg',
                'Fahd Niaz Shaikh \nAccount No: 99170105642737'),
            Text(
              'How to pay',
              style: PreMedTextTheme().heading4,
            ),
            SizedBoxes.verticalMedium,
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: PreMedColorTheme().neutral200,
                        ))),
                child: Image.asset(
                  selectedImagePath,
                  fit: BoxFit.fill,
                  width: 400,
                  height: 300,
                ),
              ),
            ),
            // SizedBox(
            //   height: 400,
            //   width: 300,
            //   child: VideoPlayerWidget(
            //     videoLink: 'https://youtu.be/POOAMMej1xU',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(
      String title, int value, String imagePath, String accountdetails) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = value;
          _showBottomSheet(title, imagePath, accountdetails);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: selectedOption == value ? Colors.blue : Colors.black,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
              title: Text(title),
              leading: Radio(
                activeColor: PreMedColorTheme().primaryColorRed,
                value: value,
                groupValue: selectedOption,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedOption = newValue!;
                    _showBottomSheet(title, imagePath,
                        accountdetails); // Show the bottom sheet on radio button change
                  });
                },
              ),
              trailing: Image.asset(
                imagePath,
                width: 100,
                height: 60,
              ),
              visualDensity: VisualDensity(horizontal: -4.0),
            ),
          ),
        ),
      ),
    );
  }
}

class LocalImageDisplayCheckout extends StatefulWidget {
  @override
  _LocalImageDisplayCheckoutState createState() =>
      _LocalImageDisplayCheckoutState();
}

class _LocalImageDisplayCheckoutState extends State<LocalImageDisplayCheckout> {
  File? _image;
  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider = Provider.of<AskAnExpertProvider>(context);

    Future<void> _pickImage() async {
      final imagePicker = ImagePicker();
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        askAnExpertProvider.uploadedImage = File(pickedFile.path);
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 100,
          width: double.infinity,
          decoration: ShapeDecoration(
            color: PreMedColorTheme().white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_image != null)
                Image.file(
                  _image!,
                  fit: BoxFit.cover, // Use BoxFit.cover for a larger image
                  width: double
                      .infinity, // Expand the image to the container's width
                  height: double
                      .infinity, // Expand the image to the container's height
                ),
              if (_image == null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        PremedAssets.Payment,
                        width: 50,
                        height: 50,
                        fit: BoxFit.fill,
                      ),
                      Text('Upload the screenshot of the \nPayment Receipt',
                          textAlign: TextAlign.center,
                          style: PreMedTextTheme().body.copyWith(
                                color: PreMedColorTheme().black,
                              )),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBoxes.verticalMicro,
        SizedBox(
          width: 110,
          height: 50,
          child: TextButton(
            onPressed: _pickImage,
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                BorderSide(color: Colors.black, width: 2),
              ),
              backgroundColor: MaterialStateProperty.all(
                  PreMedColorTheme().primaryColorBlue500),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Upload',
                  style: PreMedTextTheme().small.copyWith(
                        color: PreMedColorTheme().white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 0.11,
                      ),
                ),
                SizedBoxes.horizontalMedium,
                Image.asset(PremedAssets.Paymentupload),
              ],
            ),
          ),
        ),
        SizedBoxes.verticalMedium
      ],
    );
  }
}
