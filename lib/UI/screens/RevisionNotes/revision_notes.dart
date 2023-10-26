import 'package:premedpk_mobile_app/UI/Widgets/pdf_widgets/pdf_display_widget.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/utils/Data/notesdata.dart';

class RevisionNotes extends StatelessWidget {
  const RevisionNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(PremedAssets.EsIcon),
                  SizedBoxes.horizontalMedium,
                  Text(
                    'Revision Notes',
                    style: PreMedTextTheme()
                        .heading6
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ],
              ),
              const Icon(
                Icons.search,
                color: Colors.white,
              )
            ],
          ),
          bottom: const TabBar(
            isScrollable: true, // Make tabs scrollable
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Biology'),
              Tab(text: 'Chemistry'),
              Tab(text: 'Physics'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
          child: TabBarView(
            children: [
              PdfDisplay(notes: notesData),
              PdfDisplay(
                notes: notesData
                    .where((note) => note.subject == 'Biology')
                    .toList(),
              ),
              PdfDisplay(
                notes: notesData
                    .where((note) => note.subject == 'Chemistry')
                    .toList(),
              ),
              PdfDisplay(
                notes: notesData
                    .where((note) => note.subject == 'Physics')
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
