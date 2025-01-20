import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

import '../dashboard_screen.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({
    super.key,
    required this.icon,
    required this.text1,
    this.bgColor = Colors.blue, // default background color
    required this.onTap,
    required this.text2,
  });

  final String icon;
  final String text1;
  final String text2;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width:
              MediaQuery.of(context).size.width * 0.43, // 40% of screen width
          height:
              MediaQuery.of(context).size.height * 0.09, // 10% of screen height
          decoration: BoxDecoration(
            color: bgColor, // use the provided background color
            borderRadius: BorderRadius.circular(12),
            boxShadow: CustomBoxShadow.boxShadow40
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, bottom: 10),
                child: Image.asset(
                  icon,
                  width: MediaQuery.of(context).size.width *
                      0.1, // 10% of screen width
                  height: MediaQuery.of(context).size.width *
                      0.1, // 10% of screen width
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w900,
                        fontSize: MediaQuery.of(context).size.width *
                            0.04, // Responsive font size
                      ),
                    ),
                    Text(
                      text2,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.width *
                            0.025, // Responsive font size
                      ),
                    )
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
