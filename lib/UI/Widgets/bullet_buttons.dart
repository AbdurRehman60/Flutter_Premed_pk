import 'package:premedpk_mobile_app/export.dart';

class BulletButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const BulletButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<bool>(
          value: isSelected,
          groupValue:
              false, // Set groupValue to true to group the Radio buttons
          onChanged: (bool? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
        Text(text),
      ],
    );
  }
}

class CustomBulletButtons extends StatefulWidget {
  const CustomBulletButtons({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BulletbuttonsState createState() => _BulletbuttonsState();
}

class _BulletbuttonsState extends State<CustomBulletButtons> {
  bool option1Selected = false;
  bool option2Selected = false;
  bool option3Selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BulletButton(
            text: 'FSc 1st Year/AS Level',
            isSelected: option1Selected,
            onChanged: (value) {
              setState(() {
                option1Selected = value;
              });
            },
          ),
          BulletButton(
            text: 'FSc 1st Year/AS Level',
            isSelected: option2Selected,
            onChanged: (value) {
              setState(() {
                option2Selected = value;
              });
            },
          ),
          BulletButton(
            text: 'Have given MDCAT & improving',
            isSelected: option3Selected,
            onChanged: (value) {
              setState(() {
                option3Selected = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
