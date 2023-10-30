import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/check_box.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/export.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneFieldWithCheckbox extends StatefulWidget {
  @override
  _PhoneFieldWithCheckboxState createState() => _PhoneFieldWithCheckboxState();
}

class _PhoneFieldWithCheckboxState extends State<PhoneFieldWithCheckbox> {
  bool isPhoneFieldEnabled = false;
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: [
            // const CustomCheckBox(),
            SizedBoxes.horizontalLarge,
            Flexible(
              child: Text(
                'Is this number available on WhatsApp?',
                style: PreMedTextTheme().subtext,
              ),
            ),
          ],
        ),
        SizedBoxes.verticalBig,
        // const PhoneDropdown()
      ],
    );
  }
}
