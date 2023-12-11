import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:premedpk_mobile_app/UI/screens/Onboarding/widgets/check_box.dart';
import 'package:premedpk_mobile_app/constants/sized_boxes.dart';
import 'package:premedpk_mobile_app/providers/auth_provider.dart';
import 'package:premedpk_mobile_app/UI/widgets/phone_dropdown.dart';
import 'package:provider/provider.dart';

class PhoneFieldWithCheckbox extends StatefulWidget {
  final void Function(String) onWhatsAppNumberSelected;

  final bool isPhoneFieldEnabled;
  final String? initialValue;
  const PhoneFieldWithCheckbox({
    super.key,
    required this.onWhatsAppNumberSelected,
    required this.isPhoneFieldEnabled,
    this.initialValue,
  });

  @override
  State<PhoneFieldWithCheckbox> createState() => _PhoneFieldWithCheckboxState();
}

class _PhoneFieldWithCheckboxState extends State<PhoneFieldWithCheckbox> {
  TextEditingController whatsappNumberController = TextEditingController();
  bool showTF = false;

  @override
  void initState() {
    super.initState();
    showTF = !widget.isPhoneFieldEnabled;
  }

  void togglePhoneField(bool value) {
    setState(() {
      Provider.of<AuthProvider>(context, listen: false).whatsappNumber = '';
      showTF = !value;
      if (!showTF) {
        resetPhoneField();
      }
    });
  }

  void resetPhoneField() {
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
          initialValue: !showTF,
          onChanged: togglePhoneField,
        ),
        SizedBoxes.verticalBig,
        Visibility(
          visible: showTF,
          child: PhoneDropdown(
            onPhoneNumberSelected: (PhoneNumber phoneNumber) {
              auth.whatsappNumber = phoneNumber.completeNumber;
            },
            hintText: 'Enter your WhatsApp Number',
            initialValue: widget.initialValue,
          ),
        )
      ],
    );
  }
}
