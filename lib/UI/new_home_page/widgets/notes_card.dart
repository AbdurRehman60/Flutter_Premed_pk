import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    super.key,
    required this.icon,
    required this.text,
    required this.text1,
    this.bgColor = Colors.blue, // default background color
    required this.onTap,
    required this.text2,
  });

  final String icon;
  final String text;
  final String text1;
  final String text2;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 186,
          height: 96,
          decoration: BoxDecoration(
            color: bgColor, // use the provided background color
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  icon,
                  width: 70,
                  height: 95,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text,
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w800,
                            fontSize: 9,
                            color: const Color.fromARGB(255, 74, 74, 74))),
                    Text(text1,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        )),
                    Text(text2,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
