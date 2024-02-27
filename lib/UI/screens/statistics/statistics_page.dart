import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(23, 10, 23, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statistics',
                style: GoogleFonts.rubik(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF000000),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                'Your PreMed Statistics and Performance Overview',
                style: GoogleFonts.rubik(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF000000),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 19),
                  decoration: BoxDecoration(
                    color:  Color(0xA6FFFFFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/chartcircle.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
