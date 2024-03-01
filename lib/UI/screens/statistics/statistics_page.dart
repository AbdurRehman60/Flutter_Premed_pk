import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/material_card.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/stat_details_holder.dart';
import 'package:premedpk_mobile_app/UI/screens/statistics/widgets/subject_percentage.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(23, 10, 23, 10),
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
                SizedBoxes.vertical3Px,
                Text(
                  'Your PreMed Statistics and Performance Overview',
                  style: GoogleFonts.rubik(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF000000),
                  ),
                ),
                SizedBoxes.verticalBig,
                MaterialCard(
                  height: 150,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          'assets/images/chartcircle.png',
                        ),
                      ),
                      SizedBoxes.horizontalLarge,
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
                SizedBoxes.verticalBig,
                Row(
                  children: [
                    MaterialCard(
                      height: 164,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 75,
                            child: Image.asset('assets/images/infocell.png'),
                          ),
                          SizedBoxes.vertical10Px,
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
                    SizedBoxes.horizontalTiny,
                    MaterialCard(
                      height: 164,
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
                  ],
                ),
                SizedBoxes.verticalBig,
                const MaterialCard(
                  height: 121,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StatDetailHolder(
                              textColor: Color(0xFF60CDBB),
                              count: '3',
                              details: 'Decks\nAttempted'),
                          StatDetailHolder(
                              textColor: Color(0xFFEC5863),
                              count: '45',
                              details: 'Test\nAttempted'),
                          StatDetailHolder(
                              textColor: Color(0xFFFFC372),
                              count: '20',
                              details: 'Practice Tests\nAttempted'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalBig,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: MaterialCard(
                        height: 150,
                        child: StatDetailHolder(
                            textColor: Color(0xFF60CDBB),
                            count: '2:00',
                            details: 'Total \n Time Taken',
                            preDetails: 'Minutes'),
                      ),
                    ),
                    SizedBoxes.horizontalTiny,
                    const Expanded(
                      child: MaterialCard(
                        height: 150,
                        child: StatDetailHolder(
                          textColor: Color(0xFFEC5863),
                          count: '0.60',
                          details: 'Avg.Time Per \n Question',
                          preDetails: 'Seconds',
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
