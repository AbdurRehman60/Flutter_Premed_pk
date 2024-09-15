import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:provider/provider.dart';

import '../../../../providers/vaultProviders/premed_provider.dart';
import '../dashboard_screen.dart';

class QbankCard extends StatelessWidget {
  const QbankCard(
      {super.key,
      required this.icon,
      required this.text,
      required this.text1,
      required this.onTap,
      this.bgColor = Colors.blue,
      required this.isPreMed
      });

  final String icon;
  final String text;
  final String text1;
  final Color bgColor;
  final VoidCallback onTap;
  final bool isPreMed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width:
              MediaQuery.of(context).size.width * 0.45, // 45% of screen width
          height:
              MediaQuery.of(context).size.height * 0.09, // 10% of screen height
          decoration: BoxDecoration(
            color: bgColor, // use the provided background color
            borderRadius: BorderRadius.circular(10),
            boxShadow: CustomBoxShadow.boxShadow40
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height *
                      0.015, // Responsive vertical padding
                  horizontal: MediaQuery.of(context).size.width *
                      0.03, // Responsive horizontal padding
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
                          color: Provider.of<PreMedProvider>(context).isPreMed
                              ? PreMedColorTheme().red
                              : PreMedColorTheme().blue,
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
