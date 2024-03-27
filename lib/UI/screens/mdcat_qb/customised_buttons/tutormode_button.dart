import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class TutorMode extends StatefulWidget {
  const TutorMode({Key? key}) : super(key: key);

  @override
  _TutorModeState createState() => _TutorModeState();
}

class _TutorModeState extends State<TutorMode> {
  bool isTutorModeSelected = true;

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
              child: ModeButton(
                text: 'TUTOR MODE',
                color: isTutorModeSelected
                    ? PreMedColorTheme().primaryColorRed
                    : PreMedColorTheme().neutral100,
                textColor: isTutorModeSelected
                    ? PreMedColorTheme().white
                    : PreMedColorTheme().black,
                borderColor: isTutorModeSelected
                    ? PreMedColorTheme().primaryColorRed200
                    : Colors.transparent,
                onPressed: () {
                  setState(() {
                    isTutorModeSelected = true;
                  });
                },
              ),
            ),
          ),
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 175,
              child: ModeButton(
                text: 'TIMED TEST MODE',
                color: isTutorModeSelected
                    ? PreMedColorTheme().neutral100
                    : PreMedColorTheme().primaryColorRed, // Change color when selected
                textColor: isTutorModeSelected
                    ? PreMedColorTheme().black
                    : PreMedColorTheme().white,
                borderColor: isTutorModeSelected
                    ? Colors.transparent // Transparent border when tutor mode selected
                    : PreMedColorTheme().primaryColorRed200, // Red border when timed test mode selected
                onPressed: () {
                  setState(() {
                    isTutorModeSelected = false;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




class ModeButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;

  const ModeButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.borderColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderColor,
              width: 3,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 125,
                decoration: BoxDecoration(
                  color: PreMedColorTheme().white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  text == 'TUTOR MODE' ? 'Free' : 'MDCAT QBANK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PreMedColorTheme().primaryColorRed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

