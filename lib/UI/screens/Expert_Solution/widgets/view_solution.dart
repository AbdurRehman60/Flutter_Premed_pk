import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/tags_row.dart';
import 'package:premedpk_mobile_app/UI/screens/expert_solution/widgets/video_player.dart';
import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/doubtsolve_model.dart';

class ViewSolution extends StatelessWidget {
  final Doubt doubt;
  const ViewSolution({
    Key? key,
    required this.doubt,
  }) : super(key: key);

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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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

                      // Insert VideoPlayerWidget here

                      Image.network(
                          'https://premed.pk/assets/CoreTeamImage-06df697b.png'),
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
                      SizedBox(
                        width: 320,
                        height: 180,
                        child: VideoPlayerWidget(
                          videoLink: doubt.videoLink,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBoxes.verticalExtraGargangua,
              CustomButton(buttonText: 'Add a Feedback', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
