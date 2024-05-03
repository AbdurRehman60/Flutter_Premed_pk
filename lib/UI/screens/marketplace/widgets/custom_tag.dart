import 'package:premedpk_mobile_app/constants/constants_export.dart';

class RibbonTag extends StatelessWidget {

  const RibbonTag({
    super.key,
    required this.imagePath,
    required this.text,
  });
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(imagePath,),
        Align(
          child: Text(
            text,
            style: PreMedTextTheme().body.copyWith(
              color:PreMedColorTheme().white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
