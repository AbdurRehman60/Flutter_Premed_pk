// ignore: file_names
import 'package:premedpk_mobile_app/models/11th_hour_reel_model.dart';

import '../../../../../constants/constants_export.dart';

class EleventhHourCard extends StatelessWidget {
  const EleventhHourCard({super.key, required this.eleventhHourReel});
  final EleventhHourReel eleventhHourReel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 93,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.50)),
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5, left: 10),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 105,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    eleventhHourReel.imageUrl,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      eleventhHourReel.title.toUpperCase(),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: PreMedTextTheme().heading1.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'short'.toUpperCase(),
                          style: PreMedTextTheme().heading1.copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: PreMedColorTheme().primaryColorRed,
                              ),
                        ),
                        TextSpan(
                          text: 'listing'.toUpperCase(),
                          style: PreMedTextTheme().heading1.copyWith(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
