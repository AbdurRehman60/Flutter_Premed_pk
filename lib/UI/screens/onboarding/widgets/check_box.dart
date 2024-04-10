import 'package:premedpk_mobile_app/constants/constants_export.dart';

class CustomCheckBox extends StatefulWidget {

  const CustomCheckBox({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.label,
  });
  final bool initialValue;
  final Function(bool) onChanged;
  final String label;

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
          widget.onChanged(isChecked);
        });
      },
      child: Row(
        children: [
          Container(
            width: checkBoxSize,
            height: checkBoxSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(
                color: isChecked
                    ? PreMedColorTheme().tickcolor
                    : PreMedColorTheme().neutral500,
                width: 0.5, // Border width
              ),
              color: isChecked
                  ? PreMedColorTheme()
                  .customCheckboxColor // Checked background color
                  : PreMedColorTheme().white, // Unchecked background color
            ),
            child: isChecked
                ? Icon(
              Icons.check,
              size: checkBoxSize * 0.8,
              color: PreMedColorTheme().tickcolor, // Checkmark color
            )
                : null,
          ),
          SizedBoxes.horizontalMedium,
          Flexible(
            child: Text(
              widget.label,
              style: PreMedTextTheme().subtext,
              // No overflow and maxLines properties
            ),
          ),
          SizedBoxes.horizontalTiny,
        ],
      ),
    );
  }
}
