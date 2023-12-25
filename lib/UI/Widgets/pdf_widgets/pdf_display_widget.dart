import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class PdfDisplay extends StatelessWidget {
  const PdfDisplay({
    super.key,
    required this.notes,
    this.isSearch = false,
    required this.isLoading,
  });
  final List<NoteModel> notes;
  final bool isSearch;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (notes.isNotEmpty) {
      return GridView.builder(
        itemCount: notes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 3,
          mainAxisExtent: 290,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PDFTile(
            note: notes[index],
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

class PDFTile extends StatelessWidget {
  const PDFTile({
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
          buildPdfIcon(note.coverImageURL),
          SizedBoxes.verticalMedium,
          Text(
            note.title,
            style: PreMedTextTheme().headline,
            textAlign: TextAlign.center,
          ),
          SizedBoxes.verticalMicro,
          if (note.pages != null)
            Text(
              '${note.pages} Pages',
              textAlign: TextAlign.center,
              style: PreMedTextTheme()
                  .small
                  .copyWith(color: PreMedColorTheme().neutral400, fontSize: 14),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}

Widget buildPdfIcon(String imageUrl) {
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
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
        child: Text(
          'Loading',
          style: PreMedTextTheme().heading1.copyWith(
                color: PreMedColorTheme().primaryColorRed,
              ),
        ),
      );
    },
  );
}
