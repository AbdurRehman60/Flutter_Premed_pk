import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.text1,
    required this.onTap,
    required this.text2,
    this.bgColor = Colors.blue, // default background color
  }) : super(key: key);

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
          width:
              MediaQuery.of(context).size.width * 0.45, // 45% of screen width
          height:
              MediaQuery.of(context).size.height * 0.10, // 12% of screen height
          decoration: BoxDecoration(
            color: bgColor, // use the provided background color
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  icon,
                  width: MediaQuery.of(context).size.width *
                      0.15, // 20% of screen width
                  height: MediaQuery.of(context).size.height *
                      0.1, // 10% of screen height
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.width *
                          0.02, // Responsive font size
                      color: const Color.fromARGB(255, 74, 74, 74),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    text1,
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w900,
                      fontSize: MediaQuery.of(context).size.width *
                          0.035, // Responsive font size
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    text2,
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.width *
                          0.030, // Responsive font size
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
