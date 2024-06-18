import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class StatDetailHolder1 extends StatelessWidget {
  const StatDetailHolder1(
      {super.key,
      required this.count,
      required this.details,
      this.preDetails,
      required this.textColor});
  final dynamic count;
  final String? preDetails;
  final String details;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: GoogleFonts.rubik(
            height: 1.3,
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: textColor,
          ),
        ),
        if (preDetails != null)
          Text(
            preDetails ?? '',
            style: GoogleFonts.rubik(
              height: 1.3,
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: const Color(0x59000000),
            ),
          ),
        Text(
          details,
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
            height: 1.3,
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: const Color(0xFF000000),
          ),
        )
      ],
    );
  }
}
