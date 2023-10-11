import 'package:flutter/material.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key});

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
      children: [
        ListTile(
          title: Text('FSc 1st Year/AS Level'),
          leading: Radio(
            value: options[0],
            groupValue: currentOption,
            onChanged: (value) {
              setState(() {
                currentOption = value.toString();
              });
            },
          ),
        ),
        ListTile(
          title: Text('FSc 2nd Year/A2 Level'),
          leading: Radio(
              value: options[1],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              }),
        ),
        ListTile(
          title: Text('Have given MDCAT & improving'),
          leading: Radio(
              value: options[2],
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                });
              }),
        )
      ],
    );
  }
}
