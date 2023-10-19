import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/es_list_card.dart';
import 'package:premedpk_mobile_app/constants/assets.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/constants/text_theme.dart';

class ExpertSolutionHome extends StatelessWidget {
  const ExpertSolutionHome({Key? key});

  @override
  Widget build(BuildContext context) {
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
                  toolbarHeight: 60,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  pinned: true,
                  expandedHeight: 160.0,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Stack(
                    // Wrap FlexibleSpaceBar with Stack
                    children: [
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(PremedAssets.EsIcon),
                                SizedBox(width: 16), // Use SizedBox for spacing
                                Text(
                                  'Expert Solution',
                                  style: PreMedTextTheme().heading5.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: PreMedColorTheme().white,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16), // Use SizedBox for spacing
                            Text(
                              'Get top-notch video solution answers to your MDCAT questions from top-merit experts 🙌🏻',
                              style: PreMedTextTheme()
                                  .body
                                  .copyWith(color: PreMedColorTheme().white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
          body: TabBarView(
            children: tabs.map((String name) {
              return Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    key: PageStorageKey<String>(name),
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  // Your list items here
                                  const CardList(
                                    mainText:
                                        'Identify the sentence with the incorrect use of apostrophe from the following sentences and tell the answer',
                                    tags: [
                                      // Tags data here
                                    ],
                                    subtext:
                                        'I can\'t understand the question and the options provided. Please help me; my paper is in 3 days. I need to complete this mock.',
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: PreMedColorTheme().neutral300,
                                  ),
                                ],
                              );
                            },
                            childCount: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
