import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class CustomTextBox extends StatelessWidget {

  const CustomTextBox({
    super.key,
    required this.height,
    required this.borderRadius,
    required this.hintText,
    required this.controller,
  });
  final double height;
  final double borderRadius;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintMaxLines: 5,
            hintStyle: PreMedTextTheme().body1.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: PreMedColorTheme().neutral400
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
