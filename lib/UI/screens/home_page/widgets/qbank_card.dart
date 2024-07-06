import 'package:premedpk_mobile_app/constants/constants_export.dart';

class Qbank extends StatelessWidget {
  const Qbank({
    super.key,
    required this.icon,
    this.bgColor = Colors.black12,
    required this.onTap,
  });

  final String icon;
  final Color bgColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.26, // 25% of screen width
        height:
            MediaQuery.of(context).size.height * 0.13, // 20% of screen height
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
                width: MediaQuery.of(context).size.width *
                    0.25, // 25% of screen width
                height: MediaQuery.of(context).size.height *
                    0.13, // 20% of screen height
              )
            ])
          ],
        ),
      ),
    );
  }
}
