import 'package:premedpk_mobile_app/constants/constants_export.dart';

class MenuTile extends StatelessWidget {
  final String heading;

  final String icon;

  final VoidCallback onTap;
  const MenuTile({
    super.key,
    required this.heading,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PreMedColorTheme().white, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    icon,
                    fit: BoxFit.contain,
                    width: 32,
                    height: 32,
                  ),
                  SizedBoxes.horizontalMedium,
                  Text(
                    heading,
                    style: PreMedTextTheme()
                        .body
                        .copyWith(color: PreMedColorTheme().neutral500),
                  ),
                ],
              ),
              SizedBoxes.verticalLarge,
              Row(
                children: [
                  SizedBoxes.horizontalBig,
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
