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

  TextEditingController whatsappNumberController = TextEditingController();

  void togglePhoneField(bool value) {
    setState(() {
      isPhoneFieldEnabled = !value;
      if (!isPhoneFieldEnabled) {
        resetPhoneField();
      }
    });
  }

  void resetPhoneField() {
    // Clear the phone number and reset the phone field
    whatsappNumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CustomCheckBox(
          label: "Is this number available on WhatsApp?",
          initialValue: true, // By default, it is checked
          onChanged: togglePhoneField, // Toggle phone field visibility
        ),
        SizedBoxes.verticalBig,
        Visibility(
          visible: isPhoneFieldEnabled,
          child: PhoneDropdown(
            onPhoneNumberSelected: (PhoneNumber phoneNumber) {
              auth.whatsappNumber = phoneNumber.completeNumber;
            },
            hintText: 'Enter your WhatsApp Number',
          ),
        )
      ],
    );
  }
}
