import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

class PdfDisplay extends StatelessWidget {
  final List<NoteModel> notes;
  final bool isSearch;
  final bool isLoading;
  const PdfDisplay({
    super.key,
    required this.notes,
    this.isSearch = false,
    required this.isLoading,
  });

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
  final NoteModel note;

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
          note.pages != null
              ? Text(
                  '${note.pages} Pages',
                  textAlign: TextAlign.center,
                  style: PreMedTextTheme().small.copyWith(
                      color: PreMedColorTheme().neutral400, fontSize: 14),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
