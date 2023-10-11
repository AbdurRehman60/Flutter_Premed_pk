import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class OptionalCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PhoneFieldWithCheckbox(),
      ),
    );
  }
}

class PhoneFieldWithCheckbox extends StatefulWidget {
  @override
  _PhoneFieldWithCheckboxState createState() => _PhoneFieldWithCheckboxState();
}

class _PhoneFieldWithCheckboxState extends State<PhoneFieldWithCheckbox> {
  bool isPhoneFieldEnabled = false;
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Checkbox(
                value: isPhoneFieldEnabled,
                onChanged: (bool? value) {
                  setState(() {
                    isPhoneFieldEnabled = value ?? true;
                  });
                },
              ),
              Text('Is this number available on WhatsApp?'),
            ],
          ),
          SizedBoxes.verticalTiny,
          IntlPhoneField(
            enabled: isPhoneFieldEnabled,
            controller: phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
            ),
            initialCountryCode: 'PK',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ],
      ),
    );
  }
}
