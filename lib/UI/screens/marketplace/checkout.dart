import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/video_player.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int selectedOption = 0; // Initialize selectedOption to a default value

  void _showBottomSheet(String optionText, String imagePath) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 500,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                width: 100,
                height: 60,
              ),
              Text(
                'Transfer the amount to these accounts \nand upload the screenshot of the receipt',
              )
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
            buildListTile('Easypaisa', 1, 'assets/images/easypaisa.jpg'),
            buildListTile('Jazzcash', 2, 'assets/images/jazzcash.png'),
            buildListTile('Banktransfer', 3, 'assets/images/meezan.jpg'),
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
                  PremedAssets.HowtoPay,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 400,
              width: 300,
              child: VideoPlayerWidget(
                videoLink: 'https://youtu.be/POOAMMej1xU',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile(String title, int value, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = value;
          _showBottomSheet(title, imagePath);
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
                    _showBottomSheet(title,
                        imagePath); // Show the bottom sheet on radio button change
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
