import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/sized_boxes.dart';

class NotesContainerWidget extends StatelessWidget {
  const NotesContainerWidget(
      {super.key,
      required this.iconName,
      required this.title,
      required this.onTap});
  final String iconName;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 1,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFFF7F3F5),
        child: Container(
          height: 89,
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/$iconName.png',
                height: 32,
                width: 32,
              ),
              SizedBoxes.horizontal12Px,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.rubik(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                    SizedBoxes.verticalTiny,
                    Text(
                      'Comprehensive study notes for Biology, Physics and Chemistry',
                      style: GoogleFonts.rubik(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBoxes.horizontal12Px,
              SvgPicture.asset(
                'assets/icons/right-arrow.svg',
                height: 16,
                width: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
