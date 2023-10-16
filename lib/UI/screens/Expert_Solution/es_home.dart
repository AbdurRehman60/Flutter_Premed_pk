import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/tab_bar.dart';
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
      // appBar: AppBar(
      //   flexibleSpace: Column(
      //     children: [
      //       Container(
      //         width: MediaQuery.sizeOf(context).width,
      //         decoration: ShapeDecoration(
      //           gradient: PreMedColorTheme().primaryGradient,
      //           shape: const RoundedRectangleBorder(
      //             borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(16),
      //               bottomRight: Radius.circular(16),
      //             ),
      //           ),
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 16),
      //               child: Column(
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Image.asset(PremedAssets.EsIcon),
      //                       SizedBoxes.horizontalMedium,
      //                       Text(
      //                         'Expert Solution',
      //                         style: PreMedTextTheme()
      //                             .heading5
      //                             .copyWith(color: PreMedColorTheme().white),
      //                       ),
      //                     ],
      //                   ),
      //                   SizedBoxes.verticalBig,
      //                   Text(
      //                     'Get top-notch video solution answers to your MDCAT questions from top-merit experts',
      //                     style: PreMedTextTheme()
      //                         .subtext
      //                         .copyWith(color: PreMedColorTheme().white),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                   SizedBoxes.verticalBig,
      //                 ],
      //               ),
      //             ),
      //             CustomTabBar()
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      body: SafeArea(
        child: ListView.builder(
          itemCount: tags.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CardList(
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
            );
            // Card(
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.all(16.0),
            //         child: Text('Your Main Text $index'),
            //       ),
            //       Row(
            //         children: tags
            //             .map((tag) => TagsRow(
            //                 tagName: tag.tagName, isResource: tag.isResource))
            //             .toList(),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.all(16.0),
            //         child: Text('Your Subtext Here'),
            //       ),
            //     ],
            //   ),
            // );
          },
        ),
      ),
    );
  }
}

class TagsRow extends StatelessWidget {
  final String tagName;
  final bool isResource;

  TagsRow({required this.tagName, required this.isResource});

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
