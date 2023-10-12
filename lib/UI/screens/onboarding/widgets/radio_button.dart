import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/export.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({Key? key});

  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

List<String> options = [
  'FSc 1st Year/AS Level',
  'FSc 2nd Year/A2 Level',
  'Have given MDCAT & improving'
];

class _RadioButtonsState extends State<RadioButtons> {
  String currentOption = options[0];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        return Row(
          children: [
            Radio(
              value: option,
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              },
              visualDensity: VisualDensity.compact,
              activeColor: PreMedColorTheme().primaryColorRed,
            ),
            Flexible(
              child: Text(
                option,
                style: PreMedTextTheme().subtext,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
