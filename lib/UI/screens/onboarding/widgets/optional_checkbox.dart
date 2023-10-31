import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/check_box.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:provider/provider.dart';

import '../../../../repository/auth_provider.dart';

class PhoneFieldWithCheckbox extends StatefulWidget {
  final void Function(String) onWhatsAppNumberSelected;

  PhoneFieldWithCheckbox({required this.onWhatsAppNumberSelected});

  @override
  _PhoneFieldWithCheckboxState createState() => _PhoneFieldWithCheckboxState();
}

class _PhoneFieldWithCheckboxState extends State<PhoneFieldWithCheckbox> {
  bool isPhoneFieldEnabled = false;

  TextEditingController WhatsappNumberController = TextEditingController();

  void togglePhoneField(bool value) {
    setState(() {
      isPhoneFieldEnabled = !value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: [
            CustomCheckBox(
              initialValue: true, // By default, it is checked
              onChanged: togglePhoneField, // Toggle phone field visibility
            ),
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
        Visibility(
          visible:
              isPhoneFieldEnabled, // Show the phone field if isPhoneFieldEnabled is true
          child:
              PhoneDropdown(onPhoneNumberSelected: (PhoneNumber phoneNumber) {
            auth.whatsappNumber = phoneNumber.completeNumber;
          }),
        )
      ],
    );
  }
}
