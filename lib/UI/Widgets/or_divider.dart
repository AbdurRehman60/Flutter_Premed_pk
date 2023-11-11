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
          child: Divider(
            color: PreMedColorTheme().neutral400,
            thickness: 1.5,
          ),
        ),
        SizedBoxes.horizontalMicro,
        Text('OR',
            style: PreMedTextTheme().heading6.copyWith(
                  fontWeight: FontWeights.medium,
                  color: PreMedColorTheme().neutral400,
                )),
        SizedBoxes.horizontalMicro,
        Expanded(
          child: Divider(
            color: PreMedColorTheme().neutral400,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}
