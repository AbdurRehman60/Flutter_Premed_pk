import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/essentialStuff/estuff_pdf_view.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/models/essence_stuff_model.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/engineering_access_providers.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/essen_stuff_pro.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constants/constants_export.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../Widgets/global_widgets/empty_state.dart';
import '../../screens/estuff_home.dart';
import '../../widgets/custom_dropdown.dart';

class EstuffNotesHome extends StatefulWidget {
  const EstuffNotesHome({super.key});

  @override
  State<EstuffNotesHome> createState() => _StudyNotesHomeState();
}

class _StudyNotesHomeState extends State<EstuffNotesHome> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedProvince = 'All';
  List<EssenceStuffModel> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EngineeringEssentialStuffProvider>(context, listen: false)
          .getEssentialStuff()
          .then((_) {
        _filterNotes();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    _filterNotes();
  }

  void _handleProvinceSelected(String province) {
    setState(() {
      _selectedProvince = province;
    });
    _filterNotes();
  }

  void _filterNotes() {
    final vaultStudyNotesProvider =
        Provider.of<EngineeringEssentialStuffProvider>(context, listen: false);
    final allNotes = vaultStudyNotesProvider.essentialStuffList;

    setState(() {
      _filteredNotes = allNotes.where((note) {
        final matchesSearchQuery = note.topicName
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
        final matchesProvince =
            _selectedProvince == 'All' || note.province == _selectedProvince;

        return matchesSearchQuery && matchesProvince;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EngineeringEssentialStuffProvider>(
        builder: (context, vaultstudtNotesProvider, _) {
      final bool isLoading =
          vaultstudtNotesProvider.fetchStatus == FetchStatus.fetching;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFFBF0F3),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
                child: AppBar( centerTitle: false,
              actions: [
                CustomDropdownbtn(onProvinceSelected: _handleProvinceSelected),
              ],
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
            SizedBoxes.verticalBig,
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Column(
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
                    'Studying and revising have never been easier. We have most comprehensive notes in town.',
                    style: PreMedTextTheme()
                        .heading1
                        .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBoxes.vertical10Px,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 40,
                      offset: Offset(0, 20),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF5898FF)),
                    hintText: 'Search',
                    hintStyle: PreMedTextTheme().heading1.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                        _handleSearch('');
                      },
                      icon: const Icon(Icons.clear),
                      color: PreMedColorTheme().blue,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (text) {
                    _handleSearch(text);
                  },
                ),
              ),
            ),
            SizedBoxes.vertical15Px,
            Expanded(
              child: EngineeringPdfDisplayer(
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

class EngineeringPdfDisplayer extends StatelessWidget {
  const EngineeringPdfDisplayer({
    super.key,
    required this.notes,
    this.isSearch = false,
    required this.isLoading,
    required this.categoryName,
  });
  final List<EssenceStuffModel> notes;
  final bool isSearch;
  final bool isLoading;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return  Center(
        child: CircularProgressIndicator(color: PreMedColorTheme().blue,),
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
            hasAccess: Provider.of<PreEngAccessProvider>(context,listen: false).hasEngEssentials,
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
    // Function to handle dialog display
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

    // Function to handle tile click
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
      onTap: !hasAccess && note.access == 'Paid'
          ? showUnlockDialog // Show dialog if locked
          : onTileClick, // Navigate if accessible
      child: Stack(
        children: [
          Container(
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
                    child: buildPdfIcon(note.thumbnailImageUrl ?? ''),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      'Essential Stuff'.toUpperCase(),
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
                    note.board,
                    style: PreMedTextTheme()
                        .heading1
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 10),
                  )
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
