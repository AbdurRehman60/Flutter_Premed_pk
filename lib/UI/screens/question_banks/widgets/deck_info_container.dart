import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/sized_boxes.dart';
import '../../../../models/deck_model.dart';
class DeckInfoContainer extends StatelessWidget {
  const DeckInfoContainer({super.key,required this.qbank, required this.onTap,});
  final DeckModel qbank;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 26.0),
        child: Material(
          elevation: 1,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(15),
          color:  const Color(0xBFFFFFFF),
          child: Container(
            height: 110,
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                  NetworkImage(qbank.deckGroupImage),
                ),
                SizedBoxes.horizontal12Px,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qbank.deckGrpName,
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: const Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                    Text(
                      '${qbank.deckGroupLenght.toString()} Papers',
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: const Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
