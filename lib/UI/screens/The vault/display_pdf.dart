import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/vaultpdfview.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/user_provider.dart';

class PdfDisplayer extends StatelessWidget {
  const PdfDisplayer({
    super.key,
    required this.notes,
    this.isSearch = false,
    required this.isLoading,
    required this.categoryName,
    required this.hasAccess,
  });
  final List<VaultNotesModel> notes;
  final bool isSearch;
  final bool isLoading;
  final String categoryName;
  final bool hasAccess;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Provider.of<PreMedProvider>(context, listen: false).isPreMed
              ? PreMedColorTheme().red
              : PreMedColorTheme().blue,
        ),
      );
    } else if (notes.isNotEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 23),
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 25,
          mainAxisExtent: 290,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PDFTileVault(
            note: notes[index],
            categoryName: categoryName,
            hasAccess: hasAccess,
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


//Topical Guides
class PDFTileVault extends StatelessWidget {
  const PDFTileVault({
    super.key,
    required this.note,
    required this.categoryName,
    required this.hasAccess,
  });

  final VaultNotesModel note;
  final String categoryName;
  final bool hasAccess;

  @override
  Widget build(BuildContext context) {
    void onTileClick() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VaultPdfViewer(
            vaultNotesModel: note,
            notesCategory: categoryName,
          ),
        ),
      );
    }

    void showUnlockDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          final String appToken = userProvider.user?.info.appToken ?? '';
          return AlertDialog(
            title: const Text('Purchase Plan'),
            content: const Text(
                'You need to purchase the Ultimate plan to access this note.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _launchURL(appToken);
                },
                child: const Text('Purchase'),
              ),
            ],
          );
        },
      );
    }

    return InkWell(
      onTap: !hasAccess && note.access == 'Paid'
          ? showUnlockDialog // Show dialog if locked
          : onTileClick, // Navigate if accessible
      child: Stack(
        children: [
          Container(
            width: 220, // Fixed width
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 40,
                  offset: Offset(0, 20),
                )
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.85),
              border: Border.all(color: Colors.white.withOpacity(0.50)),
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
                    child: buildPdfIcon(note.thumbnailImageUrl ?? ''),
                  ),
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
                  SizedBoxes.vertical5Px,
                  Text(
                    note.subject.toUpperCase(),
                    style: PreMedTextTheme().heading1.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
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
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
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

Future<void> _launchURL(String appToken) async {
  final Uri url = Uri.parse('https://www.premed.pk/?token=$appToken');

  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

Widget buildPdfIcon(String imageUrl) {
  return Image.network(
    imageUrl,
    fit: BoxFit.fill,
    width: 142,
    height: 200,
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: 142,
        height: 200,
        decoration: BoxDecoration(
          color: PreMedColorTheme().neutral500,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'Loading',
            style: PreMedTextTheme().heading1.copyWith(
                  color: PreMedColorTheme().primaryColorRed,
                ),
          ),
        ),
      );
    },
  );
}
