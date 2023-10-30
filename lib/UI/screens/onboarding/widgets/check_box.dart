import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';

class CustomCheckBox extends StatefulWidget {
  final bool initialValue;
  final Function(bool) onChanged;

  CustomCheckBox({required this.initialValue, required this.onChanged});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  double checkBoxSize =
      18.0; // Initialize the local state with the initial value

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
          widget.onChanged(isChecked); // Notify the parent about the change
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
