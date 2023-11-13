import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants_export.dart';

class ProvincialGuides extends StatelessWidget {
  const ProvincialGuides({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesProvider guidesProvider =
        Provider.of<NotesProvider>(context, listen: true);

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
                      builder: (context) => PdfSearch(
                        notesList: guidesProvider.guidesList,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          bottom: const TabBar(
            isScrollable: true,
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
              PdfDisplay(notes: guidesProvider.guidesList),
              PdfDisplay(
                notes: guidesProvider.guidesList
                    .where((note) => note.province == 'Sindh')
                    .toList(),
              ),
              PdfDisplay(
                notes: guidesProvider.guidesList
                    .where((note) => note.province == 'Punjab')
                    .toList(),
              ),
              PdfDisplay(
                notes: guidesProvider.guidesList
                    .where((note) => note.province == 'Balochistan')
                    .toList(),
              ),
              PdfDisplay(
                notes: guidesProvider.guidesList
                    .where((note) => note.province == 'KPK')
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
