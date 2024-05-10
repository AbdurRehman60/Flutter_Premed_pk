import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/sized_boxes.dart';
class QbankStatsContainer extends StatelessWidget {
  const QbankStatsContainer({super.key, required this.title, required this.totalMcqs, required this.completedPercentage, required this.MCQSDone, required this.totalMCQS});
  final String title;
  final String totalMcqs;
  final String completedPercentage;
  final String MCQSDone;
  final String totalMCQS;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(15),
      color: const Color(0xFFF7F3F5),
      child: Container(
        width: double.infinity,
        padding:
        const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(PremedAssets.MDCATQbankLogo),
                  width: 70,
                  height: 35,
                ),
                SizedBoxes.horizontal10Px,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          totalMcqs,
                          style: GoogleFonts.rubik(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        SizedBoxes.horizontal24Px,
                        Text(
                          '$completedPercentage% Completed',
                          style: GoogleFonts.rubik(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  PremedAssets.RightArrow,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
            SizedBoxes.vertical15Px,
            Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: LinearProgressIndicator(
                                backgroundColor: const Color(
                                    0x1A000000), // Grey color for the remaining progress
                                valueColor: const AlwaysStoppedAnimation<
                                    Color>(
                                    Color(
                                        0xFF5898FF)), // Blue color for the progress
                                value: 1,
                                borderRadius:
                                BorderRadius.circular(50),
                              ),
                            ),
                            SizedBoxes.horizontal15Px,
                            Text(
                              '$completedPercentage% Completed',
                              style: GoogleFonts.rubik(
                                fontWeight: FontWeight.normal,
                                fontSize: 8,
                                color: const Color(0xFF000000),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBoxes.verticalTiny,
                    Row(
                      children: [
                        Text(
                          '$MCQSDone MCQS Done',
                          style: GoogleFonts.rubik(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        SizedBoxes.horizontal24Px,
                        Text(
                          '$totalMCQS MCQS Total',
                          style: GoogleFonts.rubik(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
