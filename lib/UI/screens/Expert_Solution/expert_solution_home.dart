import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/doubt_view_list.dart';
import 'package:premedpk_mobile_app/UI/screens/The%20vault/widgets/back_button.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/providers/expert_solution_provider.dart';
import 'package:premedpk_mobile_app/providers/upload_image_provider.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';

import 'package:provider/provider.dart';

class ExpertSolutionHome extends StatelessWidget {
  const ExpertSolutionHome({super.key});

  @override
  Widget build(BuildContext context) {
    final askAnExpertProvider =
    Provider.of<AskAnExpertProvider>(context, listen: false);

    askAnExpertProvider.getDoubts();

    final List<String> tabs = <String>['Solved Questions', 'Pending Questions'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar( centerTitle: false,
            backgroundColor: PreMedColorTheme().background,
            leading: const PopButton(),
            automaticallyImplyLeading: false,
          ),
        ),
        backgroundColor: PreMedColorTheme().background,
        body: Column(children: [
          SizedBoxes.verticalExtraGargangua,
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Expert Solutions',
                      style: PreMedTextTheme().heading6.copyWith(
                        color: PreMedColorTheme().black,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Get answers to brain-teasing questions',
                        style: PreMedTextTheme().subtext.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: PreMedColorTheme().black,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBoxes.verticalMedium,
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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
                tabs: tabs.map((String name) => Tab(text: name)).toList(),
                unselectedLabelColor: Colors.black,
                labelColor: PreMedColorTheme().white,
                indicator: BoxDecoration(
                  border: Border.all(
                      width: 3, color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().primaryColorRed: PreMedColorTheme().primaryColorBlue),
                  borderRadius: BorderRadius.circular(10),
                  color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: TabBarView(
                children: [
                  DoubtListView(solved: true),
                  DoubtListView(solved: false),
                ],
              ),
            ),
          ),
        ]),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().primaryColorRed : PreMedColorTheme().primaryColorBlue,
              width: 3,
            ),
          ),
          child: FloatingActionButton(
            backgroundColor: Provider.of<PreMedProvider>(context).isPreMed ? PreMedColorTheme().red : PreMedColorTheme().blue,
            onPressed: () {
              final askAnExpertProvider =
              Provider.of<AskAnExpertProvider>(context, listen: false);
              final uplaodImageProvider =
              Provider.of<UplaodImageProvider>(context, listen: false);
              askAnExpertProvider.resetState(uplaodImageProvider);
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
      ),
    );
  }
}