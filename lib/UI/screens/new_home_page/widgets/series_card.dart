import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class SeriesCard extends StatelessWidget {
  const SeriesCard({
    Key? key,
    required this.text,
    required this.text1,
    required this.onTap,
    this.bgColor = Colors.blue, // default background color
  }) : super(key: key);

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
          width:
              MediaQuery.of(context).size.width * 0.43, // 45% of screen width
          height:
              MediaQuery.of(context).size.height * 0.10, // 10% of screen height
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
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height *
                  0.015, // Responsive vertical padding
              horizontal: MediaQuery.of(context).size.width *
                  0.04, // Responsive horizontal padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w800,
                    fontSize: MediaQuery.of(context).size.width *
                        0.020, // Responsive font size
                    color: const Color.fromARGB(255, 74, 74, 74),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.005), // Responsive height
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "The ",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width *
                              0.035, // Responsive font size
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "11th Hour ",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width *
                              0.035, // Responsive font size
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(
                        text: "Prep Series™",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width *
                              0.035, // Responsive font size
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.002), // Responsive height
                Text(
                  text1,
                  style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width *
                        0.022, // Responsive font size
                    color: Colors.red,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
