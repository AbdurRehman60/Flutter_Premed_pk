import 'package:premedpk_mobile_app/export.dart';

class CardList extends StatelessWidget {
  final String mainText;
  final List<Map<String, dynamic>> tags;
  final String subtext;
  const CardList({
    Key? key,
    required this.mainText,
    required this.subtext,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBoxes.verticalMedium,
          Text(
            mainText,
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
          Text(
            subtext,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: PreMedTextTheme()
                .body
                .copyWith(color: PreMedColorTheme().neutral500),
          ),
          // Divider(
          //   thickness: 1,
          //   color: PreMedColorTheme().neutral500,
          // )
        ],
      ),
    );
  }
}

class TagsRow extends StatelessWidget {
  const TagsRow({
    super.key,
    required this.tagName,
    required this.isResource,
  });
  final String tagName;
  final bool isResource;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isResource
            ? PreMedColorTheme().primaryColorRed100
            : PreMedColorTheme().primaryColorBlue100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(tagName,
          style: PreMedTextTheme().small.copyWith(
                color: isResource
                    ? PreMedColorTheme().primaryColorRed800
                    : PreMedColorTheme().primaryColorBlue800,
              )),
    );
  }
}
