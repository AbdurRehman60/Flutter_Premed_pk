import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/es_list_card.dart';
import 'package:premedpk_mobile_app/constants/color_theme.dart';
import 'package:premedpk_mobile_app/export.dart';

class ExpertSolutionHome extends StatelessWidget {
  const ExpertSolutionHome({Key? key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Solved Questions', 'Pending Questions'];
    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  centerTitle: true,

                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(PremedAssets.EsIcon),
                      SizedBoxes.horizontalLarge,
                      Text(
                        'Expert Solution',
                        style: PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white),
                      ),
                    ],
                  ),
                  // This is the title in the app bar.
                  pinned: true,
                  expandedHeight: 160.0,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: FlexibleSpaceBar(
                    // This is the title in the app bar.
                    background: Container(
                      decoration: ShapeDecoration(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          gradient: PreMedColorTheme().primaryGradient),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBoxes.verticalLarge,
                            Text(
                                'Get top-notch video solution answers to your MDCAT questions from top-merit experts 🙌🏻',
                                style: PreMedTextTheme()
                                    .body
                                    .copyWith(color: PreMedColorTheme().white))
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    const CardList(
                                      mainText:
                                          'Identify the sentence with the incorrect use of apostrophe from the following sentences and tell the answer',
                                      tags: [
                                        {"tagName": "Tag1", "isResource": true},
                                        {"tagName": "Tag2", "isResource": true},
                                        {
                                          "tagName": "tag3",
                                          "isResource": false
                                        },
                                        {
                                          "tagName": "tag1234567891011121",
                                          "isResource": false
                                        },
                                        {
                                          "tagName": "tag3",
                                          "isResource": false
                                        },
                                        {
                                          "tagName": "tag3",
                                          "isResource": false
                                        },
                                        {
                                          "tagName": "tag3",
                                          "isResource": false
                                        },
                                        {
                                          "tagName": "tag3",
                                          "isResource": false
                                        },
                                        {
                                          "tagName": "tag3",
                                          "isResource": false
                                        },
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
                              childCount: 30, // You can adjust this value.
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
