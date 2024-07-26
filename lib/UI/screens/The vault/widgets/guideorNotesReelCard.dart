
import 'package:shimmer/shimmer.dart';
import '../../../../constants/constants_export.dart';
class DummyNotesCard extends StatelessWidget {
  const DummyNotesCard({super.key});

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
              height: 53,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(PremedAssets.premedlogo),
                ),
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
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Text(
                        'Loading',
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
                  ),
                  Text(
                    '       '.toUpperCase(),
                    style: PreMedTextTheme().heading1.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: PreMedColorTheme().primaryColorRed,
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


