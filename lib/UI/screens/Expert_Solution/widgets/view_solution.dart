import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/tags_row.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/video_player.dart';
import 'package:premedpk_mobile_app/UI/widgets/video_player/video_player.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';
import 'package:video_player/video_player.dart';

class ViewSolution extends StatelessWidget {
  final Doubt doubt;
  const ViewSolution({
    Key? key,
    required this.doubt,
  }) : super(key: key);

  void _showReviewModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ReviewModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> tags = [
      {"tagName": doubt.resource, "isResource": true},
      {"tagName": doubt.subject, "isResource": false},
      doubt.topic != null ? {"tagName": doubt.topic, "isResource": false} : {},
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('View Solution'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Doubt',
                style: PreMedTextTheme().heading5,
                textAlign: TextAlign.left,
              ),
              Divider(
                color: PreMedColorTheme().neutral200,
              ),
              Column(
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

                  // Insert VideoPlayerWidget here

                  Image.network(doubt.imgURL),
                  SizedBoxes.verticalMedium,
                  Text(
                    doubt.description,
                    style: PreMedTextTheme().headline,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                  ),

                  Text(
                    'Solution',
                    style: PreMedTextTheme()
                        .subtext
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBoxes.verticalMedium,
                  VideoScreen(
                    url: doubt.videoLink,
                  )
                ],
              ),
              SizedBoxes.verticalExtraGargangua,
              CustomButton(
                buttonText: 'Add a Feedback',
                onPressed: () {
                  _showReviewModal(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewModal extends StatefulWidget {
  @override
  _ReviewModalState createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  int selectedRating = 0;

  void _setRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add a Feedback',
            style: PreMedTextTheme().subtext,
          ),
          SizedBoxes.verticalMedium,
          Text(
            'How well did you understand?',
            style: PreMedTextTheme()
                .body
                .copyWith(color: PreMedColorTheme().neutral400),
          ),
          SizedBoxes.verticalMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              final starNumber = index + 1;
              return InkWell(
                onTap: () {
                  _setRating(starNumber);
                },
                child: Icon(
                  Icons.star,
                  size: 40,
                  color:
                      starNumber <= selectedRating ? Colors.amber : Colors.grey,
                ),
              );
            }),
          ),
          SizedBoxes.verticalMedium,
          CustomButton(
              buttonText: 'Submit',
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
