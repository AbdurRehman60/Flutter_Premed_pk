import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/models/cheatsheetModel.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';

import '../../../../providers/vaultProviders/shortListing_providers.dart';
import '../display_pdf.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/topic_button.dart';

class ShortlistingsHome extends StatefulWidget {
  const ShortlistingsHome({super.key});

  @override
  State<ShortlistingsHome> createState() => _ShortlistingsHomeState();
}

class _ShortlistingsHomeState extends State<ShortlistingsHome> {
  final TextEditingController _searchController = TextEditingController();
  String _activeTopic = 'Chemistry';
  String _selectedProvince = 'All';
  List<VaultNotesModel> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShortListingsProvider>(context, listen: false)
          .fetchNotess()
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

  void _handleTopicTap(String topicName) {
    setState(() {
      _activeTopic = topicName;
    });
    _filterNotes();
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
    final cheatSheetsProvider =
        Provider.of<ShortListingsProvider>(context, listen: false);
    final allNotes = cheatSheetsProvider.vaultNotesList;

    setState(() {
      _filteredNotes = allNotes.where((note) {
        final matchesTopic = note.subject == _activeTopic;
        final matchesSearchQuery = note.topicName
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
        final matchesProvince =
            _selectedProvince == 'All' || note.province == _selectedProvince;
        return matchesTopic && matchesSearchQuery && matchesProvince;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortListingsProvider>(
        builder: (context, shortListingsProvider, _) {
      final bool isLoading =
          shortListingsProvider.vaultnotesLoadingstatus == Status.fetching;
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
              padding: const EdgeInsets.only(left: 23),
              child: Image.asset(
                height: 75,
                width: 248,
                'assets/images/vault/Group 1237-1 1.png',
              ),
            ),
            SizedBoxes.vertical10Px,
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Text(
                'One Chapter. One Page. Instant Revisions!',
                style: PreMedTextTheme()
                    .heading1
                    .copyWith(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBoxes.vertical10Px,
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Wrap(
                spacing: 12.0,
                runSpacing: 5,
                children: [
                  TopicButton(
                    topicName: 'Chemistry',
                    isActive: _activeTopic == 'Chemistry',
                    onTap: () => _handleTopicTap('Chemistry'),
                  ),
                  TopicButton(
                    topicName: 'Physics',
                    isActive: _activeTopic == 'Physics',
                    onTap: () => _handleTopicTap('Physics'),
                  ),
                  TopicButton(
                    topicName: 'Biology',
                    isActive: _activeTopic == 'Biology',
                    onTap: () => _handleTopicTap('Biology'),
                  ),
                  TopicButton(
                    topicName: 'English',
                    isActive: _activeTopic == 'English',
                    onTap: () => _handleTopicTap('English'),
                  ),
                  TopicButton(
                    topicName: 'Logical Reasoning',
                    isActive: _activeTopic == 'Logical Reasoning',
                    onTap: () => _handleTopicTap('Logical Reasoning'),
                  ),
                ],
              ),
            ),
            SizedBoxes.vertical10Px,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
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
                        _handleSearch(''); // Fetch notes without any search query
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
            SizedBoxes.vertical15Px,
            Expanded(
              child: PdfDisplayer(
                notes: _filteredNotes,
                isLoading: isLoading,
                categoryName: 'ShortListings',
              ),
            ),
          ],
        ),
      );
    });
  }
}
