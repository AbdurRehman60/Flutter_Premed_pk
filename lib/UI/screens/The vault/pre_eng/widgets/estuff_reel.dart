import 'package:cached_network_image/cached_network_image.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/essentialStuff/estuff_pdf_view.dart';
import 'package:premedpk_mobile_app/models/essence_stuff_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constants/constants_export.dart';
import '../../../../../providers/vaultProviders/engineeringProviders/essen_stuff_pro.dart';

class EngEstuffPage extends StatefulWidget {
  const EngEstuffPage({super.key});

  @override
  _EngEstuffPageState createState() => _EngEstuffPageState();
}

class _EngEstuffPageState extends State<EngEstuffPage> {
  late Future<void> _fetchEssentialStuffFuture;

  @override
  void initState() {
    super.initState();
    _fetchEssentialStuffFuture = Future.microtask(() async {
      final provider = context.read<EngineeringEssentialStuffProvider>();
      await provider.getEssentialStuff();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EngineeringEssentialStuffProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<void>(
          future: _fetchEssentialStuffFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: PreMedColorTheme().blue,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return EngineeringGuidesOrNotesDisplay(
                hasAccess: true,
                notes: provider.essentialStuffList,
                isLoading: provider.fetchStatus == FetchStatus.fetching,
                notesCategory: 'Study Notes',
              );
            }
          },
        );
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
    required this.hasAccess,
  });
  final List<EssenceStuffModel> notes;
  final bool isLoading;
  final String notesCategory;
  final bool hasAccess;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: notes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 13),
        child: EngineeringGuideOrNotesCard(
          hasAccess: hasAccess,
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
      {super.key, required this.vaultNotesModel, required this.onTap, required this.hasAccess});
  final EssenceStuffModel vaultNotesModel;
  final void Function() onTap;
  final bool hasAccess;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(children: [
        Container(
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
                    placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                          color: PreMedColorTheme().blue,
                        )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
       if(!hasAccess)
          GlassContainer(
            shadowStrength: 0,
            width: 240,
            height: 93,
            child: Center(
              child: GlassContainer(
                border: Border.all(color: Colors.white, width: 2),
                height: 32,
                width: 80,
                child: Center(
                  child: Text(
                    'Unlock',
                    style: PreMedTextTheme()
                        .heading1
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
      ]),
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
