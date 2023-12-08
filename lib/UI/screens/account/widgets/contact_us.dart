import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PreMedColorTheme().white,
        title: Text(
          'Contact US',
          style: PreMedTextTheme().heading7.copyWith(
                color: PreMedColorTheme().black,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: PreMedColorTheme().black, // Set the color for the icon
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Image.asset(PremedAssets.ContactUS),
          Text('URL launcher to be implemented here')
        ],
      )),
    );
  }
}
