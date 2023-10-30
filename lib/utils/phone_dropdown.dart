import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneDropdown extends StatelessWidget {
  final void Function(PhoneNumber) onPhoneNumberSelected;
  const PhoneDropdown({super.key, required this.onPhoneNumberSelected});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: 'PK',
      // onSaved: onPhoneNumberSelected,
      // controller: phoneController,
      // focusNode: focusNode,
      onChanged: onPhoneNumberSelected,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
