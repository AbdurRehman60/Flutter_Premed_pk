import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/assets.dart';
import 'package:premedpk_mobile_app/models/recent_activity_model.dart';
import '../../../../constants/sized_boxes.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget(
      {super.key, required this.recent, this.line, required this.topPadding});
  final RecentActivityModel recent;
  final Widget? line;
  final EdgeInsetsGeometry topPadding;

  @override
  Widget build(BuildContext context) {
    final int completionPercentage =
        (recent.totalAttempts / recent.totalQuestions * 100).ceil();

    return Padding(
      padding: topPadding,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 28,
                height: 35,
                child: SvgPicture.asset(
                  PremedAssets.DocumentIcon,
                ),
              ),
              SizedBoxes.horizontal15Px,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recent.deckName,
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xFF000000),
                      height: 1.3,
                    ),
                  ),
                  SizedBoxes.verticalTiny,
                  Row(
                    children: [
                      SizedBox(
                        width: 175,
                        child: LinearProgressIndicator(
                          backgroundColor: const Color(0x1A000000), // Grey color for the remaining progress
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5898FF)), // Blue color for the progress
                          value: completionPercentage/100,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      SizedBoxes.horizontal15Px,
                      Text(
                        '$completionPercentage% Completed',
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.normal,
                          fontSize: 8,
                          color: const Color(0xFF000000),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                  SizedBoxes.verticalTiny,
                  Row(
                    children: [
                      Text(
                        recent.attemptedDate,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.normal,
                          fontSize: 8,
                          color: const Color(0xFF000000),
                          height: 1.3,
                        ),
                      ),
                      SizedBoxes.horizontalTiny,
                      Text(
                        recent.mode,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                          color: const Color(0xFFEC5863),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          line!,
        ],
      ),
    );
  }
}
