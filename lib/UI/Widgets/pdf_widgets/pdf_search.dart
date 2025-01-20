import 'package:premedpk_mobile_app/UI/screens/revision_notes/revision_notes.dart';
import 'package:premedpk_mobile_app/UI/widgets/pdf_widgets/pdf_display_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class PdfSearch extends StatefulWidget {
  const PdfSearch({super.key, this.notesList});

  final List<NoteModel>? notesList;

  @override
  State<PdfSearch> createState() => _PdfSearchState();
}

class _PdfSearchState extends State<PdfSearch> {
  List<NoteModel>? filteredList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = widget.notesList;
  }

  void updateList(String value) {
    setState(() {
      filteredList = widget.notesList!
          .where((element) =>
          element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear(); // Clear the text field
      filteredList = widget.notesList; // Reset to the full list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(builder: (context, notesProvider, _) {
      if (notesProvider.notesList.isEmpty) {
        notesProvider.fetchNotes();
      }
      return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppBar( centerTitle: false,
                backgroundColor: PreMedColorTheme().white,
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
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                automaticallyImplyLeading: false,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBoxes.horizontalMedium,
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().white,
                        child: IconButton(
                          onPressed: () {
                            notesProvider.fetchNotes();
                          },
                          icon: Icon(
                            Icons.replay_outlined,
                            color: PreMedColorTheme().primaryColorRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().white,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: PreMedColorTheme().primaryColorBlue,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RevisionNotes()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Revision Notes',
                            style: PreMedTextTheme().heading6.copyWith(
                              color: PreMedColorTheme().black,
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                            'Your performance, facts and figures, all at a glance!',
                            style: PreMedTextTheme().subtext.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: PreMedColorTheme().black,
                            )),
                      ],
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  Container(
                    decoration: BoxDecoration(
                      color: PreMedColorTheme().white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController, // Assign the controller
                      onChanged: (value) => updateList(value),
                      style: TextStyle(color: PreMedColorTheme().black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: PreMedColorTheme().white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search',
                        prefixIcon: Icon(
                          Icons.search,
                          color: PreMedColorTheme().primaryColorBlue,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: PreMedColorTheme().primaryColorRed,
                          ),
                          onPressed: () {
                            searchController.clear(); // Clear the text field
                            updateList(''); // Reset the filtered data
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBoxes.verticalMedium,
                  Expanded(
                    child: Consumer<NotesProvider>(
                        builder: (context, notesProvider, _) {
                          return PdfDisplay(
                            notes: filteredList!,
                            isSearch: true,
                            isLoading: notesProvider.guidesloadingStatus ==
                                Status.Fetching,
                          );
                        }),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}