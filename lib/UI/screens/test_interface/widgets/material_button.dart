import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialOptionButton extends StatelessWidget {
  const MaterialOptionButton(
      {super.key,
      required this.title,
      required this.iconName,
      required this.color,
      this.bgColor});
  final String title;
  final String iconName;
  final Color color;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(55),
      color: bgColor ?? const Color(0xFFFFFFFF),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        height: 30,
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/$iconName.svg'),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
