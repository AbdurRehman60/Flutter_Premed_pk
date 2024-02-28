import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({super.key, required this.height, required this.child});
  final double height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 25),
        decoration: const BoxDecoration(
          color: Color(0xA6FFFFFF),
        ),
        child: child,
      ),
    );
  }
}
