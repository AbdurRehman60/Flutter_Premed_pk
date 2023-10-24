import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class PdfDisplay extends StatelessWidget {
  final Note note;

  PdfDisplay({
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10, // You only have one item to display
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 3,
        mainAxisExtent:
            300, // Adjust the number of columns in the grid as needed
      ),
      itemBuilder: (BuildContext context, int index) {
        return PDFTile(note: note);
      },
    );
  }
}

class PDFTile extends StatelessWidget {
  final Note note;

  PDFTile({
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.network(
              note.coverImageURL,
              height: 200,
              width: 142,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            note.title,
            style: PreMedTextTheme().headline,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${note.pages} Pages',
            textAlign: TextAlign.center,
            style: PreMedTextTheme().small.copyWith(
                  color: PreMedColorTheme().neutral400,
                ),
          ),
          // You can display other properties of the Note object as needed
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
