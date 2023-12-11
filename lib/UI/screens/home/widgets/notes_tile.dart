import 'package:premedpk_mobile_app/constants/constants_export.dart';

class NotesTile extends StatelessWidget {
  const NotesTile({
    super.key,
    required this.heading,
    required this.description,
    required this.icon,
    // required this.route,
    this.bgColor = Colors.black12,
    this.btnColor = Colors.black,
    required this.onTap,
  });
  final String heading;
  final String description;
  final String icon;
  // final Route route;
  final Color bgColor;
  final Color btnColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PreMedColorTheme().white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                  style: PreMedTextTheme().heading5,
                ),
              ],
            ),
            SizedBoxes.verticalLarge,
            Row(
              children: [
                Flexible(
                  child: Text(
                    description,
                    style: PreMedTextTheme().subtext.copyWith(
                          fontWeight: FontWeights.regular,
                          fontSize: 14,
                        ),
                  ),
                ),
                SizedBoxes.horizontalBig,
                IconButton(
                  onPressed: onTap,
                  icon: CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: PreMedColorTheme().white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
