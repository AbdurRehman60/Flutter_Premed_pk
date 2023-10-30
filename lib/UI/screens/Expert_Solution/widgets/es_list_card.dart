import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/tags_row.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/view_solution.dart';
import 'package:premedpk_mobile_app/export.dart';
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

    bool isSolved = doubt.solvedStatus ==
        doubt.solvedStatus; // Check if the doubt is solved

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
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          builder: (context) {
            List<Widget> bottomSheetChildren = [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBoxes.verticalBig,
                    Row(
                      children: [
                        SizedBoxes.horizontalMedium,
                        Text(
                          'Doubt Details',
                          style: PreMedTextTheme().heading5,
                        ),
                        SizedBoxes.horizontalMedium,
                        Container(
                          width: 55,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: isSolved
                                ? Colors.green // Solved status is green
                                : Colors
                                    .amberAccent, // Unsolved status is yellow
                          ),
                          child: Text(
                            isSolved ? 'Solved' : 'Pending',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBoxes.verticalBig,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            Image.network(
                              'https://premed.pk/assets/CoreTeamImage-06df697b.png',
                              width: 321,
                              height: 77,
                            ),
                            SizedBoxes.verticalMicro
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ];

            if (isSolved) {
              bottomSheetChildren.add(SizedBox(
                width: 320,
                child: CustomButton(
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
                    }),
              ));
            } else {
              // If the doubt is unsolved, add a SizedBox
              bottomSheetChildren.add(
                const SizedBox(
                  height: 48, // Adjust the height as needed
                ),
              );
            }

            return Column(
              children: bottomSheetChildren,
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
