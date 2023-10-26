import 'package:premedpk_mobile_app/UI/Widgets/pdf_widgets/pdf_display_widget.dart';
import 'package:premedpk_mobile_app/export.dart';

class PdfSearch extends StatefulWidget {
  const PdfSearch({Key? key}) : super(key: key);

  @override
  State<PdfSearch> createState() => _PdfSearchState();
}

class _PdfSearchState extends State<PdfSearch> {
  static List<Note> Notes_Search = notesData;
  List<Note> Notes_filtered_display = List.from(Notes_Search);

  TextEditingController searchController = TextEditingController();

  void updateList(String value) {
    setState(() {
      Notes_filtered_display = Notes_Search.where((element) =>
          element.title.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear(); // Clear the text field
      Notes_filtered_display =
          List.from(Notes_Search); // Reset to the full list
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
              notes: Notes_filtered_display,
              isSearch: true,
            ) // Use filtered data here
                )
          ],
        ),
      ),
    );
  }
}
