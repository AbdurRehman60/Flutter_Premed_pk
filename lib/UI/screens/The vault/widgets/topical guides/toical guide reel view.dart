import 'package:cached_network_image/cached_network_image.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/screens/vaultpdfview.dart';
import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constants/constants_export.dart';
import '../../../../../providers/user_provider.dart';
class GuidesOrNotesDisplay extends StatelessWidget {
  const GuidesOrNotesDisplay({
    super.key,
    required this.notes,
    required this.isLoading,
    required this.notesCategory, required this.hasAccess,
  });
  final List<dynamic> notes;
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
        child: GuideOrNotesCard(
          hasAccess: hasAccess,
          vaultNotesModel: notes[index],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VaultPdfViewer(
                          vaultNotesModel: notes[index],
                          notesCategory: notesCategory,
                        )));
          },
        ),
      ),
    );
  }
}

class GuideOrNotesCard extends StatelessWidget {
  const GuideOrNotesCard({
    super.key,
    required this.vaultNotesModel,
    required this.onTap,
    required this.hasAccess,
  });

  final VaultNotesModel vaultNotesModel;
  final void Function() onTap;
  final bool hasAccess;

  @override
  Widget build(BuildContext context) {
    Future<void> _launchURL(String appToken) async {
      final Uri url = Uri.parse('https://www.premed.pk/?token=$appToken');

      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }

    return InkWell(
      onTap: !hasAccess && vaultNotesModel.access == 'Paid'
          ? null // Disable default onTap for locked content
          : onTap,
      child: Stack(
        children: [
          Container(
            width: 240,
            height: 93,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5)),
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
                        color: Provider.of<PreMedProvider>(context).isPreMed
                            ? PreMedColorTheme().red
                            : PreMedColorTheme().blue,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 63,
                      width: 44,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
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
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!hasAccess && vaultNotesModel.access == 'Paid')
            GlassContainer(
              shadowStrength: 0,
              width: 240,
              height: 93,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                        final String appToken =
                            userProvider.user?.info.appToken ?? '';
                        return AlertDialog(
                          title: const Text('Purchase Plan'),
                          content: const Text(
                              'You need to purchase the Ultimate plan to upload doubts.'),
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
                  },
                  child: GlassContainer(
                    border: Border.all(color: Colors.white, width: 2),
                    height: 32,
                    width: 80,
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
