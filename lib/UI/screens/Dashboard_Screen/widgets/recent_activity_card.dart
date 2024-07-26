// ignore: file_names
// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Recent_Activity/recent_activity_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class RecentActivityCard extends StatefulWidget {
  const RecentActivityCard({
    super.key,
    required this.mode,
    required this.acivityname,
    required this.date,
    required this.progressValue,
    required this.isPreMed,
  });
  final double progressValue;

  final acivityname;
  final mode;
  final date;
  final isPreMed;

  @override
  _RecentActivityCardState createState() => _RecentActivityCardState();
}

class _RecentActivityCardState extends State<RecentActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Container(
        height: 165,
        decoration: BoxDecoration(
          color: PreMedColorTheme().white,
          borderRadius: BorderRadius.circular(15.0),
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
                              color: const Color.fromARGB(255, 74, 74, 74))),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecentActivityScreen(
                                  isPreMed: widget.isPreMed,
                                )));
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: PreMedColorTheme().red,
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
                        const SizedBox(
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
                                  valueColor: AlwaysStoppedAnimation(_getColor(
                                      widget.progressValue, widget.isPreMed)),
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
                                child: Text(widget.mode,
                                    style: GoogleFonts.rubik(
                                      color: widget.isPreMed
                                          ? PreMedColorTheme().red
                                          : PreMedColorTheme().coolBlue,
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

  Color _getColor(double progressValue, bool isPreMed) {
    if (progressValue < 0.3) {
      return isPreMed ? PreMedColorTheme().red : PreMedColorTheme().coolBlue;
    } else if (progressValue < 0.6) {
      return PreMedColorTheme().yellowlight;
    } else {
      return PreMedColorTheme().greenLight;
    }
  }
}
