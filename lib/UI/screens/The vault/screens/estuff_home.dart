import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/essentialStuff/estuff_pdf_view.dart';
import 'package:premedpk_mobile_app/models/essence_stuff_model.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/engineering_access_providers.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../providers/vaultProviders/essential_stuff_provider.dart';
import '../../../Widgets/global_widgets/empty_state.dart';
import '../display_pdf.dart';
import '../widgets/topic_button.dart';

class EstuffHomeScreen extends StatefulWidget {
  const EstuffHomeScreen({super.key});

  @override
  State<EstuffHomeScreen> createState() => _EstuffHomeScreenState();
}

class _EstuffHomeScreenState extends State<EstuffHomeScreen> {
  List<EssenceStuffModel> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EssentialStuffProvider>(context, listen: false)
          .getEssentialStuff()
          .then((_) {
        _filterNotes('MDCAT');
      });
    });
  }

  void _filterNotes(String board) {
    final eStuff = Provider.of<EssentialStuffProvider>(context, listen: false);
    final allNotes = eStuff.essentialStuffList;
    setState(() {
      _filteredNotes = allNotes.where((note) {
        final matchesSearchQuery =
            note.board.toLowerCase().contains(board.toLowerCase());

        return matchesSearchQuery;
      }).toList();
    });
  }

  String _activeTopic = 'MDCAT';

  void _handleTopicTap(String topicName) {
    setState(() {
      _activeTopic = topicName;
    });
    _filterNotes(topicName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EssentialStuffProvider, PreEngAccessProvider>(
        builder: (context, vaultTopicalGuides, preEngaccessPro, _) {
      final bool isLoading =
          vaultTopicalGuides.fetchStatus == FetchStatus.fetching;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFBF0F3),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: AppBar(
              centerTitle: false,
              title: Text(
                'The Vault',
                style: PreMedTextTheme()
                    .heading1
                    .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              backgroundColor: const Color(0xFFFBF0F3),
              leading: const PopButton(),
              automaticallyImplyLeading: false,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxes.vertical10Px,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const GradientText1(
                        text: 'Essential',
                        fontSize: 35,
                      ),
                      Text(' Stuff',
                          style: PreMedTextTheme().heading1.copyWith(
                              fontSize: 35, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBoxes.vertical10Px,
                  Text(
                    'One Chapter. One Page. Instant Revisions!',
                    style: PreMedTextTheme()
                        .heading1
                        .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBoxes.vertical10Px,
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 5,
                    children: [
                      TopicButton(
                        topicName: 'MDCAT',
                        isActive: _activeTopic == 'MDCAT',
                        onTap: () => _handleTopicTap('MDCAT'),
                      ),
                      TopicButton(
                        topicName: 'Private Universities',
                        isActive: _activeTopic == 'PRIVATE UNIVERSITIES',
                        onTap: () => _handleTopicTap('PRIVATE UNIVERSITIES'),
                      ),
                      TopicButton(
                        topicName: 'FSc',
                        isActive: _activeTopic == 'FSC',
                        onTap: () => _handleTopicTap('FSC'),
                      ),
                      TopicButton(
                        topicName: 'Government Notifications',
                        isActive: _activeTopic == 'Government Notifications',
                        onTap: () =>
                            _handleTopicTap('Government Notifications'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBoxes.vertical10Px,
            Expanded(
              child: EstuffPdfDisplayer(
                hasAccess: preEngaccessPro.hasEngEssentials,
                notes: _filteredNotes,
                isLoading: isLoading,
                categoryName: 'Essential Stuff',
              ),
            ),
          ],
        ),
      );
    });
  }
}

class EstuffPdfDisplayer extends StatelessWidget {
  const EstuffPdfDisplayer({
    super.key,
    required this.hasAccess,
    required this.notes,
    this.isSearch = false,
    required this.isLoading,
    required this.categoryName,
  });
  final List<EssenceStuffModel> notes;
  final bool isSearch;
  final bool isLoading;
  final String categoryName;
  final bool hasAccess;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (notes.isNotEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 25,
          mainAxisExtent: 290,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PDFTileVault(
            hasAccess: hasAccess,
            note: notes[index],
            categoryName: categoryName,
          );
        },
      );
    } else {
      if (isSearch) {
        return EmptyState(
          displayImage: PremedAssets.SearchemptyState,
          title: 'No results found',
          body: 'Try adjusting your search to find what you are looking for',
        );
      } else {
        return EmptyState(
          displayImage: PremedAssets.Notfoundemptystate,
          title: 'COMING SOON',
          body: "We're working on adding new notes and guides.",
        );
      }
    }
  }
}

class PDFTileVault extends StatelessWidget {
  const PDFTileVault({
    super.key,
    required this.note,
    required this.categoryName,
    required this.hasAccess,
  });

  final EssenceStuffModel note;
  final String categoryName;
  final bool hasAccess;

  @override
  Widget build(BuildContext context) {
    void onTileClick() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EstuffPdfView(
            essenceStuffModel: note,
            categoryName: categoryName,
          ),
        ),
      );
    }

    return InkWell(
      onTap: !hasAccess && note.access == 'Paid' ? null : onTileClick,
      child: Stack(
        children: [
          Container(
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.85),
              border: Border.all(color: Colors.white.withOpacity(0.50)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 40,
                  offset: Offset(0, 20),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 10,
                            offset: Offset(0, 10),
                          )
                        ],
                      ),
                      child: buildPdfIcon(note.thumbnailImageUrl ?? '')),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: Text(
                      categoryName.toUpperCase(),
                      style: PreMedTextTheme().heading1.copyWith(
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                            color: Colors.black26,
                          ),
                    ),
                  ),
                  SizedBoxes.vertical5Px,
                  Text(
                    note.topicName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: PreMedTextTheme()
                        .headline
                        .copyWith(fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          if (!hasAccess && note.access == 'Paid')
            Positioned.fill(
              child: GlassContainer(
                shadowStrength: 0,
                borderRadius: BorderRadius.circular(10),
                child: Center(
                  child: GlassContainer(
                    shadowStrength: 0,
                    height: 32,
                    width: 80,
                    border: Border.all(color: Colors.white, width: 2),
                    child: Center(
                      child: Text(
                        'Unlock',
                        style: PreMedTextTheme().heading1.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class GradientText1 extends StatelessWidget {
  const GradientText1({super.key, required this.text, required this.fontSize});
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: <Color>[Color(0xFF44009B), Color(0xFF2370CA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
