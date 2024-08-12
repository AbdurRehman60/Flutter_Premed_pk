import 'package:flutter/material.dart';

import '../../../../constants/color_theme.dart';
import '../../Dashboard_Screen/dashboard_screen.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({super.key, this.height, required this.child, this.width});
  final double? height;
  final double? width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 25),
        decoration:  BoxDecoration(
          color: PreMedColorTheme().white85,
          boxShadow: CustomBoxShadow.boxShadow40
        ),
        child: child,
      ),
    );
  }
}
