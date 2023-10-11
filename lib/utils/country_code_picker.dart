import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneDropdown extends StatelessWidget {
  const PhoneDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: 'PK',
      // focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
