import 'package:cached_network_image/cached_network_image.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/essentialStuff/estuff_pdf_view.dart';
import 'package:premedpk_mobile_app/models/essence_stuff_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constants/constants_export.dart';
import '../../../../../providers/vaultProviders/engineeringProviders/essen_stuff_pro.dart';
class EngEstuffPage extends StatelessWidget {
  const EngEstuffPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<EngineeringEssentialStuffProvider>(context, listen: false);

    return FutureBuilder(
      future: provider.getEssentialStuff(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(right: 13),
              child: DummyNotesCard(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return EngineeringGuidesOrNotesDisplay(
            notes: provider.essentialStuffList,
            isLoading: provider.fetchStatus == FetchStatus.fetching,
            notesCategory: 'Study Notes',
          );
        }
      },
    );
  }
}

class EngineeringGuidesOrNotesDisplay extends StatelessWidget {
  const EngineeringGuidesOrNotesDisplay({
    super.key,
    required this.notes,
    required this.isLoading,
    required this.notesCategory,
  });
  final List<EssenceStuffModel> notes;
  final bool isLoading;
  final String notesCategory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: notes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 13),
        child: EngineeringGuideOrNotesCard(
          vaultNotesModel: notes[index],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EstuffPdfView(
                          essenceStuffModel: notes[index],
                          categoryName: notesCategory,
                        )));
          },
        ),
      ),
    );
  }
}

class EngineeringGuideOrNotesCard extends StatelessWidget {
  const EngineeringGuideOrNotesCard(
      {super.key, required this.vaultNotesModel, required this.onTap});
  final EssenceStuffModel vaultNotesModel;
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
                      '${vaultNotesModel.category.toUpperCase()} - ${vaultNotesModel.board.toUpperCase()}',
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
