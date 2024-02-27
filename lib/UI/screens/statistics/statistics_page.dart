import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/subject_percentage.dart';
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 19, vertical: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xA6FFFFFF),
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
                      const SizedBox(
                        width: 16,
                      ),
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SubjectPercentage(
                                  percentage: '65%',
                                  subject: 'Biology',
                                  textColor: Color(0xFF42C96B),
                                ),
                                SubjectPercentage(
                                  percentage: '35%',
                                  subject: 'Physics',
                                  textColor: Color(0xFF0383BB),
                                ),
                                SubjectPercentage(
                                  percentage: '24%',
                                  subject: 'Chemistry',
                                  textColor: Color(0xFFC40052),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SubjectPercentage(
                                  percentage: '12%',
                                  subject: 'Logical Reasoning',
                                  textColor: Color(0xFF8800C3),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                SubjectPercentage(
                                  percentage: '34%',
                                  subject: 'English',
                                  textColor: Color(0xFFFB9666),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: 164,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 19, vertical: 25),
                      decoration: const BoxDecoration(
                        color: Color(0xA6FFFFFF),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 75,
                            child: Image.asset('assets/images/infocell.png'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Accuracy',
                            style: GoogleFonts.rubik(
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                              fontSize: 8,
                              color: const Color(0xFF000000),
                            ),
                          ),
                          Text(
                            'EXCELLENT',
                            style: GoogleFonts.rubik(
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: const Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: 164,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 19, vertical: 25),
                      decoration: const BoxDecoration(
                        color: Color(0xA6FFFFFF),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '459',
                            style: GoogleFonts.rubik(
                              height: 1.3,
                              fontWeight: FontWeight.w800,
                              fontSize: 35,
                              color: const Color(0xFFEC5863),
                            ),
                          ),
                          Text(
                            'Total Questions\nAttempted',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
