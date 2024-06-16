// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Recent_Activity/recent_activity_screen.dart';

class RecentActivityCard extends StatefulWidget {
  final double progressValue;
  final acivityname;
  final date;
  const RecentActivityCard({
    super.key,
    required this.acivityname,
    required this.date,
    required this.progressValue,
  });

  @override
  _RecentActivityCardState createState() => _RecentActivityCardState();
}

class _RecentActivityCardState extends State<RecentActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 165,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
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
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Recent Activity',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          )),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const RecentActivityScreen()));
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50, right: 5),
                    child: Image.asset(
                      "assets/images/QuestionMarkDocument.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.acivityname,
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25)),
                                  backgroundColor: Colors.grey[300],
                                  value: widget.progressValue.clamp(0.0, 1.0),
                                  valueColor: AlwaysStoppedAnimation(
                                      _getColor(widget.progressValue)),
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                                width: 7,
                              ),
                              Text(
                                '${(widget.progressValue * 100).toInt()}% Complete',
                                style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.date,
                                  style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  )),
                              TextButton(
                                onPressed: () {},
                                child: Text('Practice Mode',
                                    style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
