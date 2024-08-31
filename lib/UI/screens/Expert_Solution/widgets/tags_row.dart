import 'package:premedpk_mobile_app/constants/constants_export.dart';

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
    return tagName.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isResource
              ? PreMedColorTheme().primaryColorRed100
              : PreMedColorTheme().primaryColorBlue100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(tagName,
            maxLines: 1,
            style: PreMedTextTheme().small.copyWith(
              color: isResource
                  ? PreMedColorTheme().primaryColorRed800
                  : PreMedColorTheme().primaryColorBlue800,
            )),
      ),
    )
        : const SizedBox();
  }
}