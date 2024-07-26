import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/essentialStuff/estuff_pdf_view.dart';
import 'package:premedpk_mobile_app/models/essence_stuff_model.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/essen_stuff_pro.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/constants_export.dart';
import '../../../../Widgets/global_widgets/empty_state.dart';
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
                child: AppBar(
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
                  leading: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new_rounded,
                          color: PreMedColorTheme().primaryColorRed),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxes.verticalBig,
                  Image.asset(
                    height: 75,
                    width: 248,
                    'assets/images/vault/study ntes png.png',
                  ),
                  SizedBoxes.vertical10Px,
                  Text(
                    'Studying and revising have never been easier. We have most comprehensive notes in town.',
                    style: PreMedTextTheme()
                        .heading1
                        .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBoxes.vertical10Px,
                  Material(
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
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
                            color: PreMedColorTheme().primaryColorRed,
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
                  SizedBoxes.vertical10Px,
                  Expanded(
                    child: EngineeringPdfDisplayer(
                      notes: _filteredNotes,
                      isLoading: isLoading,
                      categoryName: 'Study Notes',
                    ),
                  ),
                ],
              ),
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
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (notes.isNotEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          mainAxisExtent: 290,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PDFTileVault(
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
          title: 'COMMING SOON',
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
  });
  final EssenceStuffModel note;
  final String categoryName;

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
      onTap: onTileClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.85),
          border: Border.all(color: Colors.white.withOpacity(0.50)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              buildPdfIcon(note.thumbnailImageUrl ?? ''),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Text(
                  'Study Notes'.toUpperCase(),
                  style: PreMedTextTheme().heading1.copyWith(
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    color: Colors.black26,
                  ),
                ),
              ),
              SizedBoxes.vertical3Px,
              Text(
                note.topicName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: PreMedTextTheme()
                    .headline
                    .copyWith(fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              SizedBoxes.verticalMicro,
              Text(
                '5 Pages'.toUpperCase(),
                style: PreMedTextTheme()
                    .heading1
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
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
