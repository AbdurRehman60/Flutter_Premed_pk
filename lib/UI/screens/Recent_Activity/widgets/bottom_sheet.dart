import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget(
      {super.key,
      this.progressValue,
      this.acivityname,
      this.date,
      this.mode,
      this.onTap, this.restart, this.resume});
  final double? progressValue;
  final String? acivityname;
  final String? date;
  final String? mode;
  final VoidCallback? onTap;
  final VoidCallback? restart;
  final VoidCallback? resume;

  @override

  // ignore: library_private_types_in_public_api
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
        height: screenHeight * 0.4,
        width: screenWidth,
        decoration: BoxDecoration(
          color: PreMedColorTheme().white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 60,
                    ),
                    child: Text(
                      widget.acivityname ?? '',
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            backgroundColor: Colors.grey[300],
                            value: widget.progressValue?.clamp(0.0, 1.0),
                            valueColor: AlwaysStoppedAnimation(
                                _getColor(widget.progressValue ?? 0.0)),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Text(
                          '${(widget.progressValue! * 100).toInt()}% Complete',
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
                          widget.date ?? '',
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(widget.mode ?? '',
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  color: PreMedColorTheme().red)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBoxes.horizontalExtraGargangua,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PreMedColorTheme().red,
                        elevation: 10,
                      ), // Set the color to red
                      onPressed: widget.resume,

                      child: Text(
                        'Resume Test',
                        style: GoogleFonts.rubik(
                          color: PreMedColorTheme().white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBoxes.verticalBig,
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                      ),
                      onPressed: widget.restart,
                      child: Text(
                        'Restart',
                        style: GoogleFonts.rubik(
                          color: PreMedColorTheme().red,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Color _getColor(double progressValue) {
  if (progressValue < 0.3) {
    return Colors.red;
  } else if (progressValue < 0.6) {
    return Colors.redAccent;
  } else {
    return Colors.green;
  }
}
