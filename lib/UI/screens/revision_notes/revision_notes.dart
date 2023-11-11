import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
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
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset(
                      PremedAssets.RevisionNotes,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBoxes.horizontalMedium,
                  Text(
                    'Revision Notes',
                    style: PreMedTextTheme()
                        .heading6
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PdfSearch(),
                    ),
                  );
                },
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
