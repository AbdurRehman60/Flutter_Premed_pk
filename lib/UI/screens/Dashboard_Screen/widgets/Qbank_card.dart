import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class QbankCard extends StatelessWidget {
  const QbankCard({
    super.key,
    required this.icon,
    required this.text,
    required this.text1,
    required this.onTap,
    // required this.text2,
    this.bgColor = Colors.blue, // default background color
  });

  final String icon;
  final String text;
  final String text1;
  // final String text2;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width:
              MediaQuery.of(context).size.width * 0.45, // 45% of screen width
          height:
              MediaQuery.of(context).size.height * 0.09, // 10% of screen height
          decoration: BoxDecoration(
            color: bgColor, // use the provided background color
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height *
                      0.015, // Responsive vertical padding
                  horizontal: MediaQuery.of(context).size.width *
                      0.04, // Responsive horizontal padding
                ),
                child: SvgPicture.asset(
                  icon,
                  width: MediaQuery.of(context).size.width *
                      0.05, // 15% of screen width
                  height: MediaQuery.of(context).size.height *
                      0.05, // 8% of screen height
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height *
                        0.010, // Responsive vertical padding
                    horizontal: MediaQuery.of(context).size.width *
                        0.00, // Responsive horizontal padding
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width *
                              0.030, // Responsive font size
                          color: PreMedColorTheme().red,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        text1,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width *
                              0.04, // Responsive font size
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
