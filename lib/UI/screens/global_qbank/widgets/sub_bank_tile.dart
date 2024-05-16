import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';


class SubBankTile extends StatelessWidget {
  const SubBankTile(
      {super.key, required this.details, required this.onTap});
  final Map<String, dynamic> details;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(details['deckLogo']),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    details['deckName'],
                    style: GoogleFonts.rubik(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.3,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 27,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFF5898FF),
                    ),
                    child: Text(
                      'MDCAT QBank',
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              PremedAssets.RightArrow,
              width: 28,
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}