import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/UI/screens/mdcat_qb/mdcat_qbank_yearly.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key,required this.ontap});
final void Function() ontap;
  @override
  Widget build(BuildContext context) {

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
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
                bottomRightRadius: Radius.circular(0),
                bottomLeftRadius: Radius.circular(0),
                color: PreMedColorTheme().white,
                textColor: PreMedColorTheme().black,
                showBorder: false,
                onPressed: ontap
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
                topLeftRadius: Radius.circular(8),
                bottomRightRadius: Radius.circular(8),
                bottomLeftRadius: Radius.circular(8),
                color: PreMedColorTheme().primaryColorRed,
                textColor: PreMedColorTheme().white,
                showBorder: true,
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
  final double elevation;
  final double borderRadius;
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
    this.elevation = 0,
    this.borderRadius = 8,
    this.showBorder = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
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
              style: PreMedTextTheme().subtext1.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
