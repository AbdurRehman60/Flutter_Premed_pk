import 'package:premedpk_mobile_app/UI/Widgets/pdf_widgets/pdf_display_widget.dart';
import 'package:premedpk_mobile_app/UI/Widgets/pdf_widgets/pdf_search.dart';
import 'package:premedpk_mobile_app/export.dart';

class ProvincialGuides extends StatelessWidget {
  const ProvincialGuides({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: Image.asset(PremedAssets.ProvisionalGuides),
                  ),
                  SizedBoxes.horizontalMedium,
                  Text(
                    'Provincial Guides',
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
              Tab(text: 'Sindh'),
              Tab(text: 'Punjab'),
              Tab(text: 'Balochistan'),
              Tab(text: 'KPK'),
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
                    .where((note) => note.province == 'Sindh')
                    .toList(),
              ),
              PdfDisplay(
                notes: notesData
                    .where((note) => note.province == 'Punjab')
                    .toList(),
              ),
              PdfDisplay(
                notes: notesData
                    .where((note) => note.province == 'Balochistan')
                    .toList(),
              ),
              PdfDisplay(
                notes:
                    notesData.where((note) => note.province == 'KPK').toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
