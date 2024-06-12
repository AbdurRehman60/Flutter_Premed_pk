import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'UPDATES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SvgPicture.asset(
                    "assets/icons/Sparkles.svg",
                    width: 25,
                    height: 25,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Course Added to Catalogue',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          )),
                      const SizedBox(height: 5.0),
                      Text(
                          'We have added a new course to our catalogue: "AKU Entry Test \'24 Course"',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SvgPicture.asset(
                    "assets/icons/Video.svg",
                    width: 25,
                    height: 25,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Webinar: "AKU Stage-III: Acceptance" by Hasnain Mankani',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          )),
                      SizedBox(height: 5.0),
                      Text(
                          'Join us on 20th January for a Webinar related to the Stage-III of AKU Admission Process.',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SvgPicture.asset(
                    "assets/icons/Video.svg",
                    width: 25,
                    height: 25,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Webinar: "KEMU: All You Need To Know" by Fateh Alam',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          )),
                      SizedBox(height: 5.0),
                      Text(
                          'Join us on 31st January for a Webinar related to the system and life at KEMU.',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
