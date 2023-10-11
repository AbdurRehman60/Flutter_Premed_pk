import 'package:flutter/material.dart';

class ChecBox extends StatefulWidget {
  const ChecBox({super.key});

  @override
  State<ChecBox> createState() => _ChecBoxState();
}

class _ChecBoxState extends State<ChecBox> {
  bool? isChecked = false;
  double checkBoxSize = 20.0; // Adjust the size as needed

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
      children: [
        Transform.scale(
          scale: checkBoxSize / 24.0, // 24.0 is the default size
          child: Checkbox(
            value: isChecked,
            activeColor: const Color(0xFFEC5863),
            onChanged: (newBool) {
              setState(() {
                isChecked = newBool;
              });
            },
          ),
        ),
        // You can add additional content here if needed
      ],
    );
  }
}
