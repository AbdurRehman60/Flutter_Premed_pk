import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/tab_bar.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/custom_appbar.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/es_list_card.dart';
import 'package:premedpk_mobile_app/export.dart';

class Tag {
  final String tagName;
  final bool isResource;

  Tag({required this.tagName, required this.isResource});
}

void main() {
  runApp(MaterialApp(
    home: EsHome(),
  ));
}

class EsHome extends StatelessWidget {
  final List<Tag> tags = [
    Tag(tagName: "Tag1", isResource: true),
    Tag(tagName: "Tag2", isResource: true),
    Tag(tagName: "tag3", isResource: false),
    Tag(tagName: "tag1234567891011121", isResource: false),
    Tag(tagName: "tag3", isResource: false),
    Tag(tagName: "tag3", isResource: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomSliverAppBar(),
          SliverPersistentHeader(
            delegate: _SliverTabBarDelegate(TabBar(
              indicatorColor: PreMedColorTheme().white,
              tabs: [
                Tab(
                  child: Text(
                    'Solved Questions',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ),
                Tab(
                  child: Text(
                    'Pending Questions',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(color: PreMedColorTheme().white),
                  ),
                ),
              ],
            )),
            pinned: true,
            floating: false,
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                const CardList(
                  mainText:
                      'Identify the sentence with the incorrect use of apostrophe from the following sentences and tell the ans',
                  tags: [
                    {"tagName": "Tag1", "isResource": true},
                    {"tagName": "Tag2", "isResource": true},
                    {"tagName": "tag3", "isResource": false},
                    {"tagName": "tag1234567891011121", "isResource": false},
                    {"tagName": "tag3", "isResource": false},
                    {"tagName": "tag3", "isResource": false},
                    {"tagName": "tag3", "isResource": false},
                    {"tagName": "tag3", "isResource": false},
                    {"tagName": "tag3", "isResource": false},
                  ],
                  subtext:
                      'I cant understand the questiona nd the options provided. Please help me my paper is in 3 days. I need to Complete this mock.',
                ),
                Divider(
                  thickness: 1,
                  color: PreMedColorTheme().neutral300,
                )
              ],
            ),
          )
          // Add the custom app bar here
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (BuildContext context, int index) {
          //       return Column(
          //         children: [
          //           const CardList(
          //             mainText:
          //                 'Identify the sentence with the incorrect use of apostrophe from the following sentences and tell the ans',
          //             tags: [
          //               {"tagName": "Tag1", "isResource": true},
          //               {"tagName": "Tag2", "isResource": true},
          //               {"tagName": "tag3", "isResource": false},
          //               {"tagName": "tag1234567891011121", "isResource": false},
          //               {"tagName": "tag3", "isResource": false},
          //               {"tagName": "tag3", "isResource": false},
          //               {"tagName": "tag3", "isResource": false},
          //               {"tagName": "tag3", "isResource": false},
          //               {"tagName": "tag3", "isResource": false},
          //             ],
          //             subtext:
          //                 'I cant understand the questiona nd the options provided. Please help me my paper is in 3 days. I need to Complete this mock.',
          //           ),
          //           Divider(
          //             thickness: 1,
          //             color: PreMedColorTheme().neutral300,
          //           )
          //         ],
          //       );
          //     },
          //     childCount: tags.length,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

class TagsRow extends StatelessWidget {
  final String tagName;
  final bool isResource;

  TagsRow({
    required this.tagName,
    required this.isResource,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isResource ? Colors.red : Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tagName,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
