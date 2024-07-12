import 'package:provider/provider.dart';
import '../../../../constants/constants_export.dart';
import '../../../../models/cheatsheetModel.dart';
import '../../../../providers/vaultProviders/study_notes_proivders.dart';
import '../display_pdf.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/topic_button.dart';

class StudyNotesHome extends StatefulWidget {
  const StudyNotesHome({super.key});

  @override
  State<StudyNotesHome> createState() => _StudyNotesHomeState();
}

class _StudyNotesHomeState extends State<StudyNotesHome> {
  final TextEditingController _searchController = TextEditingController();
  String _activeTopic = 'Chemistry';
  String _selectedProvince = 'All';
  List<VaultNotesModel> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VaultStudyNotesProvider>(context, listen: false)
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
        Provider.of<VaultStudyNotesProvider>(context, listen: false);
    final allNotes = vaultStudyNotesProvider.vaultNotesList;


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
    return Consumer<VaultStudyNotesProvider>(
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TopicButton(
                      topicName: 'Chemistry',
                      isActive: _activeTopic == 'Chemistry',
                      onTap: () => _handleTopicTap('Chemistry'),
                    ),
                    SizedBoxes.horizontal12Px,
                    TopicButton(
                      topicName: 'Physics',
                      isActive: _activeTopic == 'Physics',
                      onTap: () => _handleTopicTap('Physics'),
                    ),
                    SizedBoxes.horizontal12Px,
                    TopicButton(
                      topicName: 'Biology',
                      isActive: _activeTopic == 'Biology',
                      onTap: () => _handleTopicTap('Biology'),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  TopicButton(
                    topicName: 'English',
                    isActive: _activeTopic == 'English',
                    onTap: () => _handleTopicTap('English'),
                  ),
                  SizedBoxes.horizontal12Px,
                  TopicButton(
                    topicName: 'Logical Reasoning',
                    isActive: _activeTopic == 'Logical Reasoning',
                    onTap: () => _handleTopicTap('Logical Reasoning'),
                  ),
                ],
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
                          _handleSearch(
                              '');
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
                child: PdfDisplayer(
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
