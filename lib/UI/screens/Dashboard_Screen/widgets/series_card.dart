import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/UI/screens/Dashboard_Screen/dashboard_screen.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class SeriesCard extends StatelessWidget {
  const SeriesCard({
    super.key,
    required this.text,
    required this.text1,
    required this.onTap,
    this.bgColor = Colors.blue,
    required this.icon,
    required this.isNetworkImage
  });

  final String text;
  final String text1;
  final Color bgColor;
  final VoidCallback onTap;
  final String icon;
  final bool isNetworkImage;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width:
              MediaQuery.of(context).size.width * 0.43, // 45% of screen width
          height:
              MediaQuery.of(context).size.height * 0.10, // 10% of screen height
          decoration: BoxDecoration(
            color: bgColor, // use the provided background color
            borderRadius: BorderRadius.circular(10),
            boxShadow: CustomBoxShadow.boxShadow40
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height *
                    0.015, // Responsive vertical padding
                horizontal: MediaQuery.of(context).size.width *
                    0.03, // Responsive horizontal padding
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0,),
                      child: Text(
                        text,
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width *
                              0.020, // Responsive font size
                          color: const Color.fromARGB(255, 74, 74, 74),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    isNetworkImage
                        ? Image.network(icon, width: 120, height: 30,)
                        : Image.asset(icon),
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.002), // Responsive height
                    Text(
                      text1,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width *
                            0.024, // Responsive font size
                        color: PreMedColorTheme().black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ])),
        ),
      ),
    );
  }
}
