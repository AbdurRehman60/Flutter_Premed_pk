import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class SearchDisplay extends StatelessWidget {

  const SearchDisplay({
    super.key,
    required this.notes,
  });
  final List<NoteModel> notes;

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
          return SearchTile(note: notes[index]);
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(PremedAssets.SearchemptyState),
            SizedBoxes.verticalTiny,
            Text(
              'NO RESULTS FOUND',
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
                "Try adjusting your search to find what you are looking for",
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

class SearchTile extends StatelessWidget {

  const SearchTile({
    super.key,
    required this.note,
  });
  final NoteModel note;

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
