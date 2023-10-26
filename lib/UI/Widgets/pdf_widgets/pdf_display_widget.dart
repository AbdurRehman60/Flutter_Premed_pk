import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class PdfDisplay extends StatelessWidget {
  final List<Note> notes;

  PdfDisplay({
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    if (notes.isNotEmpty) {
      return GridView.builder(
        itemCount: notes.length, // You only have one item to display
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 3,
          mainAxisExtent:
              290, // Adjust the number of columns in the grid as needed
        ),
        itemBuilder: (BuildContext context, int index) {
          return PDFTile(note: notes[index]);
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(PremedAssets.Notfoundemptystate),
            SizedBoxes.verticalTiny,
            Text(
              'COMMING SOON!',
              style: PreMedTextTheme().subtext1.copyWith(
                  color: PreMedColorTheme().primaryColorRed,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.36),
            ),
            SizedBoxes.verticalTiny,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Text(
                "We're working on adding new notes and guides.",
                textAlign: TextAlign.center,
                style: PreMedTextTheme().small.copyWith(
                    color: PreMedColorTheme().neutral600,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0),
              ),
            )
          ],
        ),
      );
    }
  }
}

class PDFTile extends StatelessWidget {
  final Note note;

  const PDFTile({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    void onTileClick() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfScreen(note: note),
        ),
      );
    }

    return InkWell(
      onTap: onTileClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            note.coverImageURL,
            height: 200,
            width: 142,
            fit: BoxFit.contain,
          ),
          SizedBoxes.verticalMedium,
          Text(
            note.title,
            style: PreMedTextTheme().headline,
            textAlign: TextAlign.center,
          ),
          SizedBoxes.verticalMicro,
          Text(
            '${note.pages} Pages',
            textAlign: TextAlign.center,
            style: PreMedTextTheme()
                .small
                .copyWith(color: PreMedColorTheme().neutral400, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
