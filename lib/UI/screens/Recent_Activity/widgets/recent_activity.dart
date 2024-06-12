// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class RecentActivityCard1 extends StatefulWidget {
  const RecentActivityCard1({
    super.key,
    required this.acivityname,
    required this.date,
    required this.progressValue,
    required this.mode,
  });
  final double progressValue;
  final acivityname;
  final date;
  final mode;

  @override
  _RecentActivityCard1State createState() => _RecentActivityCard1State();
}

class _RecentActivityCard1State extends State<RecentActivityCard1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 60,
          ),
          child: Text(
            widget.acivityname,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/QuestionMarkDocument.png",
              height: 50,
              width: 50,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: LinearProgressIndicator(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  backgroundColor: Colors.grey[300],
                  value: widget.progressValue.clamp(0.0, 1.0),
                  valueColor:
                      AlwaysStoppedAnimation(_getColor(widget.progressValue)),
                  minHeight: 8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Text(
                '${(widget.progressValue * 100).toInt()}% Complete',
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.date,
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(widget.mode,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: Colors.red)),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Divider(
            color: Color.fromARGB(255, 56, 56, 56),
            thickness: 1,
          ),
        )
      ],
    );
  }

  Color _getColor(double progressValue) {
    if (progressValue < 0.3) {
      return Colors.red;
    } else if (progressValue < 0.6) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}
