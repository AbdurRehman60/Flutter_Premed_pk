import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/tags_row.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/view_solution.dart';
import 'package:premedpk_mobile_app/UI/widgets/global_widgets_export.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';
import 'package:premedpk_mobile_app/providers/vaultProviders/premed_provider.dart';
import 'package:provider/provider.dart';


class DoubtCard extends StatelessWidget {
  const DoubtCard({
    super.key,
    required this.doubt,
  });

  final Doubt doubt;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tags = [
      {"tagName": doubt.resource, "isResource": true},
      {"tagName": doubt.subject, "isResource": false},
      if (doubt.topic != null) {"tagName": doubt.topic, "isResource": false}
    ];

    final bool isSolved = doubt.solvedStatus == 'Solved';

    return InkWell(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ViewSolution(
      //         doubt: doubt,
      //       ),
      //     ),
      //   );
      // },
      onTap: () {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Doubt Details',
                          style: PreMedTextTheme().heading5,
                        ),
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
                      overflow: TextOverflow.ellipsis,
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
                      child: Image.network(
                        doubt.imgURL,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return ColoredBox(
                            color: PreMedColorTheme().neutral100,
                          );
                        },
                      ),
                    ),
                    SizedBoxes.verticalMedium,
                    if (isSolved)
                      CustomButton(
                        color: Provider.of<PreMedProvider>(context).isPreMed
                            ? PreMedColorTheme().red
                            : PreMedColorTheme().blue,
                        buttonText: 'Watch Explanation',
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ViewSolution(
                          //       doubt: doubt,
                          //     ),
                          //   ),
                          // );
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              PremedAssets.expQMark,
              color: Provider.of<PreMedProvider>(context).isPreMed
                  ? PreMedColorTheme().red
                  : PreMedColorTheme().blue,
              height: 32,
              width: 32,
            ),
            SizedBoxes.horizontal12Px,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doubt.description,
                    style: PreMedTextTheme().headline.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBoxes.vertical10Px,
                  Row(
                    children: [
                      Text(
                        doubt.resource,
                        style: PreMedTextTheme().body,
                      ),
                      SizedBoxes.horizontalTiny,
                      Text(
                        isSolved ? 'Solved' : 'Pending',
                        style: PreMedTextTheme().body.copyWith(
                          color: isSolved ? PreMedColorTheme().greenL : PreMedColorTheme().red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}