import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateCard extends StatelessWidget {
  const UpdateCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.04), // 4% of screen width
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'UPDATES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width *
                        0.035, // 3.5% of screen width
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
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), // 2% of screen height
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: SvgPicture.asset(
                    "assets/icons/Sparkles.svg",
                    width: MediaQuery.of(context).size.width *
                        0.05, // 5% of screen width
                    height: MediaQuery.of(context).size.width *
                        0.05, // 5% of screen width
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.03), // 3% of screen width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Course Added to Catalogue',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width *
                                0.028, // 2.8% of screen width
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.01), // 1% of screen height
                      Text(
                          'We have added a new course to our catalogue: "AKU Entry Test \'24 Course"',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width *
                                0.024, // 2.4% of screen width
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), // 2% of screen height
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SvgPicture.asset(
                    "assets/icons/Video.svg",
                    width: MediaQuery.of(context).size.width *
                        0.05, // 5% of screen width
                    height: MediaQuery.of(context).size.width *
                        0.05, // 5% of screen width
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.03), // 3% of screen width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Webinar: "AKU Stage-III: Acceptance" by Hasnain Mankani',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width *
                                0.026, // 2.6% of screen width
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.01), // 1% of screen height
                      Text(
                          'Join us on 20th January for a Webinar related to the Stage-III of AKU Admission Process.',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width *
                                0.024, // 2.4% of screen width
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), // 2% of screen height
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SvgPicture.asset(
                    "assets/icons/Video.svg",
                    width: MediaQuery.of(context).size.width *
                        0.05, // 5% of screen width
                    height: MediaQuery.of(context).size.width *
                        0.05, // 5% of screen width
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.03), // 3%of screen width
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Webinar: "KEMU: All You Need To Know" by Fateh Alam',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w700,
                            fontSize: MediaQuery.of(context).size.width *
                                0.026, // 2.6% of screen width
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.01), // 1% of screen height
                      Text(
                          'Join us on 31st January for a Webinar related to the system and life at KEMU.',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: MediaQuery.of(context).size.width *
                                0.024, // 2.4% of screen width
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
