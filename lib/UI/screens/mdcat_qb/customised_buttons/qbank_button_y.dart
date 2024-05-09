import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class ButtonRow extends StatefulWidget {
  final void Function() onYearlyTap;
  final void Function() onTopicalTap;

  const ButtonRow({
    Key? key,
    required this.onYearlyTap,
    required this.onTopicalTap,
  }) : super(key: key);

  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  bool yearlySelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 175,
              child: RoundedButton(
                text: 'Yearly',
                topLeftRadius: Radius.circular(8.0),
                topRightRadius: Radius.circular(8),
                bottomRightRadius: Radius.circular(8),
                bottomLeftRadius: Radius.circular(8.0),
                color: yearlySelected
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().white,
                textColor: PreMedColorTheme().white,
                showBorder: true,
                onPressed: () {
                  setState(() {
                    yearlySelected = true;
                  });
                  widget.onYearlyTap();
                },
              ),
            ),
          ),
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 175,
              child: RoundedButton(
                text: 'Topical',
                topRightRadius: Radius.circular(8.0),
                topLeftRadius: Radius.circular(0),
                bottomRightRadius: Radius.circular(8),
                bottomLeftRadius: Radius.circular(0),
                color: yearlySelected
                    ? PreMedColorTheme().white
                    : PreMedColorTheme().primaryColorRed,
                textColor: PreMedColorTheme().black,
                showBorder: false,
                onPressed: () {
                  setState(() {
                    yearlySelected = false;
                  });
                  widget.onTopicalTap();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Radius topLeftRadius;
  final Radius topRightRadius;
  final Radius bottomLeftRadius;
  final Radius bottomRightRadius;
  final Color color;
  final Color textColor;
  final bool showBorder;
  final VoidCallback? onPressed;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.topLeftRadius,
    required this.topRightRadius,
    required this.bottomLeftRadius,
    required this.bottomRightRadius,
    required this.color,
    required this.textColor,
    this.showBorder = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: topLeftRadius,
            topRight: topRightRadius,
            bottomRight: bottomRightRadius,
            bottomLeft: bottomLeftRadius,
          ),
          color: color,
          border: showBorder
              ? Border.all(
              color: PreMedColorTheme().primaryColorRed200, width: 3)
              : null,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
