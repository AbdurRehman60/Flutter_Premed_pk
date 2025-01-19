import 'package:flutter_svg/svg.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class RevisionNotes extends StatelessWidget {
  const RevisionNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, _) {
        if (notesProvider.notesList.isEmpty) {
          notesProvider.fetchNotes();
        }
        final bool isLoading =
            notesProvider.notesLoadingStatus == Status.Fetching;
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
                  child: AppBar( centerTitle: false,
                backgroundColor: PreMedColorTheme().white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Material(
                    elevation: 4,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: 37,
                      height: 37,
                      child: SvgPicture.asset(
                        'assets/icons/left-arrow.svg',
                        width: 9.33,
                        height: 18.67,
                      ),
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBoxes.horizontalMedium,
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().white,
                        child: IconButton(
                          onPressed: () {
                            notesProvider.fetchNotes();
                          },
                          icon: Icon(
                            Icons.replay_outlined,
                            color: PreMedColorTheme().primaryColorRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: PreMedColorTheme().white,
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: PreMedColorTheme().primaryColorBlue,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfSearch(
                                  notesList: notesProvider.notesList,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Revision Notes',
                          style: PreMedTextTheme().heading6.copyWith(
                                color: PreMedColorTheme().black,
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      Text(
                          'Your performance, facts and figures, all at a glance!',
                          style: PreMedTextTheme().subtext.copyWith(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: PreMedColorTheme().black,
                              )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TabBar(
                    //isScrollable: true,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Biology'),
                      Tab(text: 'Physics'),
                      Tab(text: 'Chemistry'),
                    ],
                    unselectedLabelColor: Colors.black,
                    labelColor: PreMedColorTheme().white,
                    indicator: BoxDecoration(
                      border: Border.all(
                          width: 3,
                          color: PreMedColorTheme().primaryColorRed200),
                      borderRadius: BorderRadius.circular(10),
                      color: PreMedColorTheme().primaryColorRed,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 26, 8, 0),
                  child: TabBarView(
                    children: [
                      PdfDisplay(
                        notes: notesProvider.notesList,
                        isLoading: isLoading,
                      ),
                      PdfDisplay(
                        notes: notesProvider.notesList
                            .where((note) => note.subject == 'Biology')
                            .toList(),
                        isLoading: isLoading,
                      ),
                      PdfDisplay(
                        notes: notesProvider.notesList
                            .where((note) => note.subject == 'Chemistry')
                            .toList(),
                        isLoading: isLoading,
                      ),
                      PdfDisplay(
                        notes: notesProvider.notesList
                            .where((note) => note.subject == 'Physics')
                            .toList(),
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
