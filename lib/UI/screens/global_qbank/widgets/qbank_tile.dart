import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/global_qbank/widgets/logo_avatar.dart';

import '../../../../constants/constants_export.dart';
import '../../../../models/deck_model.dart';

class QbankTile extends StatelessWidget {
  const QbankTile({super.key, required this.qbank, required this.onTap});

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
          color: const Color(0xBFFFFFFF),
          child: Container(
            height: 110,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Row(
              children: [
                GetLogo(url: qbank.deckGroupImage),
                SizedBoxes.horizontalBig,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qbank.deckGrpName,
                      style: PreMedTextTheme().heading2.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: const Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                    Text(
                      '${qbank.deckGroupLenght} Papers',
                      style: PreMedTextTheme().heading2.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: const Color(0xFF000000),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
