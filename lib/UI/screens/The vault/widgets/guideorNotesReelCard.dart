import 'package:cached_network_image/cached_network_image.dart';
import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/constants_export.dart';

class GuideOrNotesCard extends StatelessWidget {
  const GuideOrNotesCard(
      {super.key, required this.vaultNotesModel, required this.onTap});
  final VaultNotesModel vaultNotesModel;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
              CachedNetworkImage(
                  imageUrl: vaultNotesModel.thumbnailImageUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                        height: 63,
                        width: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(0, 10),
                              blurRadius: 20,
                            ),
                          ],
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        vaultNotesModel.topicName,
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
                    Text(
                      '${vaultNotesModel.subject.toUpperCase()} - ${vaultNotesModel.board.toUpperCase()}',
                      style: PreMedTextTheme().heading1.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            color: PreMedColorTheme().black.withOpacity(0.70),
                          ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
