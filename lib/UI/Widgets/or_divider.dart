import 'package:premedpk_mobile_app/constants/constants_export.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Divider(
              color: PreMedColorTheme().neutral400,
              thickness: 1.5,
            ),
          ),
        ),
        SizedBoxes.horizontalMicro,
        Text('or',
            style: PreMedTextTheme().heading6.copyWith(
                fontWeight: FontWeight.w500,
                color: PreMedColorTheme().black,
                fontSize: 15)),
        SizedBoxes.horizontalMicro,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Divider(
              color: PreMedColorTheme().neutral400,
              thickness: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
