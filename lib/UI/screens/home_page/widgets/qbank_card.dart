import 'package:premedpk_mobile_app/constants/constants_export.dart';

class Qbank extends StatelessWidget {
  const Qbank({
    super.key,
    // required this.heading,
    // required this.description,
    required this.icon,
    // required this.route,
    this.bgColor = Colors.black12,
    required this.onTap,
  });
  // final String heading;
  // final String description;
  final String icon;
  // final Route route;
  final Color bgColor;
  // final Color btnColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 120,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Image.asset(
                icon,
                fit: BoxFit.contain,
                width: 110,
                height: 120,
              )
            ])
          ],
        ),
      ),
    );
  }
}
