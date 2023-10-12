import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({Key? key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  double checkBoxSize = 18.0; // Adjust the size as needed

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: checkBoxSize,
        height: checkBoxSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0), // 2px border radius
          border: Border.all(
            color: isChecked
                ? PreMedColorTheme().primaryColorRed // Checked border color
                : PreMedColorTheme().neutral500, // Unchecked border color
            width: 0.5, // Border width
          ),
          color: isChecked
              ? PreMedColorTheme().primaryColorRed // Checked background color
              : PreMedColorTheme().white, // Unchecked background color
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: checkBoxSize * 0.8,
                color: PreMedColorTheme().white, // Checkmark color
              )
            : null,
      ),
    );
  }
}
