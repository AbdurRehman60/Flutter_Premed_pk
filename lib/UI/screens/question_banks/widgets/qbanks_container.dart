import 'package:flutter/material.dart';

class QbankContainerWidget extends StatelessWidget {
  const QbankContainerWidget({super.key, required this.iconName});
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: const Color(0xFFF7F3F5),
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: 105,
        width: 101,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/icons/$iconName.png'), fit: BoxFit.fill)),
      ),
    );
  }
}
