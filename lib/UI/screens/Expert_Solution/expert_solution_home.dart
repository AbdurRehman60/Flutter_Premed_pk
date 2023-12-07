import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/doubt_view_list.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';

import 'package:provider/provider.dart';

class ExpertSolutionHome extends StatelessWidget {
  const ExpertSolutionHome({super.key});

  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider =
        Provider.of<AskAnExpertProvider>(context, listen: false);

    Future<Map<String, dynamic>> response =
        askAnExpertProvider.getDoubts(email: 'ddd@gmail.com');

    final List<String> tabs = <String>['Solved Questions', 'Pending Questions'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  toolbarHeight: 86,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 200.0,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Stack(children: [
                    Container(
                      decoration: ShapeDecoration(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        gradient: PreMedColorTheme().primaryGradient,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBoxes.verticalMedium,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(PremedAssets.EsIcon),
                                SizedBoxes.horizontalLarge,
                                Text(
                                  'Expert Solution',
                                  style: PreMedTextTheme().heading5.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: PreMedColorTheme().white),
                                ),
                              ],
                            ),
                            SizedBoxes.verticalLarge,
                            Text(
                              'Get top-notch video solution answers to your MDCAT questions from top-merit experts 🙌🏻',
                              style: PreMedTextTheme().body.copyWith(
                                    color: PreMedColorTheme().white,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBoxes.verticalMedium,
                          ],
                        ),
                      ),
                    ),
                  ]),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0),
                        ),
                        child: TabBar(
                          indicatorColor: PreMedColorTheme().white,
                          indicatorWeight: 3.0,
                          tabs: tabs
                              .map((String name) => Tab(text: name))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              DoubtListView(solved: true),
              DoubtListView(solved: false),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: PreMedColorTheme().primaryColorRed,
          onPressed: () {
            final askAnExpertProvider =
                Provider.of<AskAnExpertProvider>(context, listen: false);
            askAnExpertProvider.resetState();
            Navigator.pushNamed(context, '/ExpertSolution');
          },
          child: Icon(
            Icons.add,
            color: PreMedColorTheme().white,
            size: 40,
            weight: 50,
            opticalSize: 100,
          ),
        ),
      ),
    );
  }
}
