import 'package:premedpk_mobile_app/UI/screens/Expert_Solution/widgets/tags_row.dart';
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
      doubt.topic != null ? {"tagName": doubt.topic, "isResource": false} : {},
    ];

    // , doubt.subject, doubt.topic!
    return InkWell(
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
            return Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text('data'))),
              ],
            );
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBoxes.verticalMedium,
              Text(
                doubt.description,
                style: PreMedTextTheme().headline,
                // Text styling here...maxLines: 1,
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
