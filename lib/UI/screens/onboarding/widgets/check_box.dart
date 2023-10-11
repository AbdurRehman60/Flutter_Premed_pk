import 'package:flutter/material.dart';

class ChecBox extends StatefulWidget {
  const ChecBox({super.key});

  @override
  State<ChecBox> createState() => _ChecBoxState();
}

class _ChecBoxState extends State<ChecBox> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: isChecked,
        activeColor: Colors.pink,
        onChanged: (newBool) {
          setState(() {
            isChecked = newBool;
          });
        },
      ),
    );
  }
}
