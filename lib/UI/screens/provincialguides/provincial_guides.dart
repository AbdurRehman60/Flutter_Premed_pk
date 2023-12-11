import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants_export.dart';

class ProvincialGuides extends StatelessWidget {
  const ProvincialGuides({super.key});

  @override
  Widget build(BuildContext context) {
    NotesProvider guidesProvider =
        Provider.of<NotesProvider>(context, listen: false);
    guidesProvider.fetchGuides();
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
                icon: const Icon(Icons.search),
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
          child: Consumer<NotesProvider>(builder: (context, guidesProvider, _) {
            bool isLoading =
                guidesProvider.guidesloadingStatus == Status.Fetching;
            return TabBarView(
              children: [
                PdfDisplay(
                  notes: guidesProvider.guidesList,
                  isLoading: isLoading,
                ),
                PdfDisplay(
                  notes: guidesProvider.guidesList
                      .where((note) => note.province == 'Sindh')
                      .toList(),
                  isLoading: isLoading,
                ),
                PdfDisplay(
                  notes: guidesProvider.guidesList
                      .where((note) => note.province == 'Punjab')
                      .toList(),
                  isLoading: isLoading,
                ),
                PdfDisplay(
                  notes: guidesProvider.guidesList
                      .where((note) => note.province == 'Balochistan')
                      .toList(),
                  isLoading: isLoading,
                ),
                PdfDisplay(
                  notes: guidesProvider.guidesList
                      .where((note) => note.province == 'KPK')
                      .toList(),
                  isLoading: isLoading,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
