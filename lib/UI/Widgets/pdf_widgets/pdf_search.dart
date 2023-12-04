import 'package:premedpk_mobile_app/UI/widgets/pdf_widgets/pdf_display_widget.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class PdfSearch extends StatefulWidget {
  final List<NoteModel>? notesList;

  const PdfSearch({Key? key, this.notesList}) : super(key: key);

  @override
  State<PdfSearch> createState() => _PdfSearchState();
}

class _PdfSearchState extends State<PdfSearch> {
  List<NoteModel>? filteredList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    filteredList = widget.notesList!;
    // TODO: implement initState
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: searchController, // Assign the controller
              onChanged: (value) => updateList(value),
              style: TextStyle(color: PreMedColorTheme().black),
              decoration: InputDecoration(
                filled: true,
                fillColor: PreMedColorTheme().white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: PreMedColorTheme().primaryColorRed,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: PreMedColorTheme().primaryColorRed,
                  ),
                  onPressed: () {
                    searchController.clear(); // Clear the text field
                    updateList(''); // Reset the filtered data
                  },
                ),
              ),
            ),
            Expanded(
              child: PdfDisplay(
                notes: filteredList!,
                isSearch: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
