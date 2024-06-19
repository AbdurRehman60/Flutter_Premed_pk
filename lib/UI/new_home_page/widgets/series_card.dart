import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class SeriesCard extends StatelessWidget {
  const SeriesCard({
    super.key,
    required this.text,
    required this.text1,
    this.bgColor = Colors.blue, // default background color
    required this.onTap,
  });

  final String text;
  final String text1;

  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            width: 180,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: 9,
                          color: const Color.fromARGB(255, 74, 74, 74))),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "The ",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        TextSpan(
                            text: " 11th Hour ",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Colors.red)),
                        TextSpan(
                            text: " Prep Series™",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(text1,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: Colors.red)),
                ],
              ),
            )),
      ),
    );
  }
}
