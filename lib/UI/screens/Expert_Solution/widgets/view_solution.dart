import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/tags_row.dart';
import 'package:premedpk_mobile_app/UI/widgets/vlc_player/vlc_player.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';

class ViewSolution extends StatelessWidget {
  const ViewSolution({
    super.key,
    required this.doubt,
  });
  final Doubt doubt;

  // void _showReviewModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return const ReviewModal();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tags = [
      {"tagName": doubt.resource, "isResource": true},
      {"tagName": doubt.subject, "isResource": false},
      if (doubt.topic != null)
        {"tagName": doubt.topic, "isResource": false}
      else
        {},
    ];
    return WillPopScope(
      onWillPop: () async {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          // Show system overlays
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: SystemUiOverlay.values);
          return false;
        }
        return true;
      },
      child: Scaffold(
          appBar: MediaQuery.of(context).orientation == Orientation.portrait
              ? AppBar(
                  centerTitle: true,
                  title: const Text('View Solution'),
                )
              : null,
          body: OrientationBuilder(
            builder: (context, orientation) {
              final bool isLandscape = orientation == Orientation.portrait;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(isLandscape ? 16.0 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isLandscape) ...{
                        Text(
                          'Doubt',
                          style: PreMedTextTheme().heading5,
                          textAlign: TextAlign.left,
                        ),
                        Divider(
                          color: PreMedColorTheme().neutral200,
                        ),
                      },
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (isLandscape) ...{
                            Text(
                              doubt.description,
                              style: PreMedTextTheme().headline,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          },
                          if (isLandscape) ...{
                            SizedBoxes.verticalMedium,
                          },
                          if (isLandscape) ...{
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
                          },
                          if (isLandscape) ...{
                            SizedBoxes.verticalMedium,
                          },
                          if (isLandscape) ...{
                            if (doubt.imgURL.isNotEmpty)
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
                              )
                            else
                              const SizedBox(),
                          },
                          if (isLandscape) ...{
                            SizedBoxes.verticalMedium,
                          },
                          if (isLandscape) ...{
                            Text(
                              doubt.description,
                              style: PreMedTextTheme().headline,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 7,
                            ),
                          },
                          if (isLandscape) ...{
                            SizedBoxes.verticalMedium,
                          },
                          if (isLandscape) ...{
                            Text(
                              'Solution',
                              style: PreMedTextTheme()
                                  .subtext
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          },
                          if (isLandscape) ...{
                            SizedBoxes.verticalMedium,
                          },
                          SizedBox(
                            width: double.infinity,
                            height: isLandscape
                                ? 400
                                : MediaQuery.of(context).size.height,
                            child: doubt.solvedStatus == 'Solved'
                                ? CustomVLCPlayer(
                                    url: doubt.videoLink,
                                  )
                                : Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.amberAccent[100],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          'Pending',
                                          textAlign: TextAlign.center,
                                          style: PreMedTextTheme()
                                              .headline
                                              .copyWith(
                                                  fontWeight:
                                                      FontWeights.regular),
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}

// class ReviewModal extends StatefulWidget {
//   const ReviewModal({super.key});

//   @override
//   _ReviewModalState createState() => _ReviewModalState();
// }

// class _ReviewModalState extends State<ReviewModal> {
//   int selectedRating = 0;

//   void _setRating(int rating) {
//     setState(() {
//       selectedRating = rating;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Add a Feedback',
//             style: PreMedTextTheme().subtext,
//           ),
//           SizedBoxes.verticalMedium,
//           Text(
//             'How well did you understand?',
//             style: PreMedTextTheme()
//                 .body
//                 .copyWith(color: PreMedColorTheme().neutral400),
//           ),
//           SizedBoxes.verticalMedium,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: List.generate(5, (index) {
//               final starNumber = index + 1;
//               return InkWell(
//                 onTap: () {
//                   _setRating(starNumber);
//                 },
//                 child: Icon(
//                   Icons.star,
//                   size: 40,
//                   color:
//                       starNumber <= selectedRating ? Colors.amber : Colors.grey,
//                 ),
//               );
//             }),
//           ),
//           SizedBoxes.verticalMedium,
//           CustomButton(
//               buttonText: 'Submit',
//               onPressed: () {
//                 Navigator.of(context).pop();
//               })
//         ],
//       ),
//     );
//   }
// }
