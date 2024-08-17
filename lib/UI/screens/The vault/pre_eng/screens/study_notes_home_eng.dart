import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/engineeringProviders/engineering_access_providers.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/constants_export.dart';
import '../../../../../models/cheatsheetModel.dart';
import '../../../../../providers/vaultProviders/engineeringProviders/eng_study_notes_provider.dart';
import '../../display_pdf.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/topic_button.dart';

class EngineeringStudyNotesHome extends StatefulWidget {
  const EngineeringStudyNotesHome({super.key});

  @override
  State<EngineeringStudyNotesHome> createState() => _StudyNotesHomeState();
}

class _StudyNotesHomeState extends State<EngineeringStudyNotesHome> {
  final TextEditingController _searchController = TextEditingController();
  String _activeTopic = 'All';
  String _selectedProvince = 'All';
  List<VaultNotesModel> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EngineeringStudyNotesProvider>(context, listen: false)
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
    final vaultStudyNotesProvider =
    Provider.of<EngineeringStudyNotesProvider>(context, listen: false);
    final allNotes = vaultStudyNotesProvider.vaultNotesList;

    setState(() {
      _filteredNotes = allNotes.where((note) {
        final matchesTopic =
            _activeTopic == 'All' || note.subject == _activeTopic;
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
    return Consumer<EngineeringStudyNotesProvider>(
        builder: (context, vaultstudtNotesProvider, _) {
          final bool isLoading =
              vaultstudtNotesProvider.vaultnotesLoadingstatus == Status.fetching;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Wrap(
                        spacing: 12.0,
                        runSpacing: 5.0,
                        children: [
                          TopicButton(
                            topicName: 'All',
                            isActive: _activeTopic == 'All',
                            onTap: () => _handleTopicTap('All'),
                          ),
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
                        ],
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
                  child: PdfDisplayer(
                    hasAccess: Provider.of<PreEngAccessProvider>(context,listen: false).hasEngNotes,
                    notes: _filteredNotes,
                    isLoading: isLoading,
                    categoryName: 'Study Notes',
                  ),
                ),
              ],
            ),
          );
        });
  }
}
