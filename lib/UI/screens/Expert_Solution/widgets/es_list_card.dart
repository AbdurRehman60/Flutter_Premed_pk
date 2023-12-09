import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/tags_row.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/view_solution.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';

class DoubtCard extends StatelessWidget {
  final Doubt doubt;
  const DoubtCard({
    Key? key,
    required this.doubt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tags = [
      {"tagName": doubt.resource, "isResource": true},
      {"tagName": doubt.subject, "isResource": false},
      if (doubt.topic != null) {"tagName": doubt.topic, "isResource": false}
    ];

    bool isSolved = doubt.solvedStatus == 'Solved';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewSolution(
              doubt: doubt,
            ),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: PreMedColorTheme().white,
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Doubt Details',
                              style: PreMedTextTheme().heading5,
                            ),
                            SizedBoxes.horizontalMedium,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: isSolved
                                    ? Colors.green[100]
                                    : Colors.amberAccent[100],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  isSolved ? 'Solved' : 'Pending',
                                  textAlign: TextAlign.center,
                                  style: PreMedTextTheme().headline.copyWith(
                                      fontWeight: FontWeights.regular),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBoxes.verticalMedium,
                        Text(
                          doubt.description,
                          style: PreMedTextTheme().headline,
                          maxLines: 4,
                        ),
                        SizedBoxes.verticalMedium,
                        Wrap(
                          runSpacing: 8,
                          spacing: 4,
                          children: tags
                              .map((tag) => TagsRow(
                                    tagName: tag['tagName'],
                                    isResource: tag['isResource'],
                                  ))
                              .toList(),
                        ),
                        SizedBoxes.verticalMedium,
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: ShapeDecoration(
                            color: PreMedColorTheme().primaryColorBlue100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Image.network(doubt.imgURL),
                        ),
                        SizedBoxes.verticalMedium,
                      ],
                    ),
                    if (isSolved)
                      CustomButton(
                        buttonText: 'Watch Explanation',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewSolution(
                                doubt: doubt,
                              ),
                            ),
                          );
                        },
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doubt.description,
                style: PreMedTextTheme().headline,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBoxes.verticalMedium,
              Wrap(
                runSpacing: 8,
                spacing: 4,
                children: tags
                    .map((tag) => TagsRow(
                          tagName: tag['tagName'],
                          isResource: tag['isResource'],
                        ))
                    .toList(),
              ),
              SizedBoxes.verticalMedium,
            ],
          ),
        ),
      ),
    );
  }
}
