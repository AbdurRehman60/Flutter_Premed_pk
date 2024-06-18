import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({super.key, this.height, required this.child, this.width});
  final double? height;
  final double? width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 25),
        decoration: const BoxDecoration(
          color: Color(0xA6FFFFFF),
        ),
        child: child,
      ),
    );
  }
}
