import 'package:premedpk_mobile_app/export.dart';

class EmptyState extends StatelessWidget {
  final String displayImage;
  final String title;
  final String body;
  const EmptyState({
    super.key,
    required this.displayImage,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(displayImage),
          SizedBoxes.verticalTiny,
          Text(
            title,
            style: PreMedTextTheme().subtext1.copyWith(
                color: PreMedColorTheme().primaryColorRed,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.36),
          ),
          SizedBoxes.verticalTiny,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: PreMedTextTheme().small.copyWith(
                  color: PreMedColorTheme().neutral600,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0),
            ),
          )
        ],
      ),
    );
  }
}
