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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: PreMedColorTheme().white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                icon,
                fit: BoxFit.contain,
                width: 32,
                height: 32,
              ),
              SizedBoxes.horizontalMedium,
              Expanded(
                child: Column(
                  children: [
                    SizedBoxes.horizontalMedium,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        heading,
                        style: PreMedTextTheme().heading5.copyWith(
                            fontWeight: FontWeight.w800, fontSize: 16
                        ),
                      ),
                    ),
                    SizedBoxes.vertical2Px,

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        description,
                        style: PreMedTextTheme().subtext.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 13

                        ),
                      ),
                    ),
                    SizedBoxes.horizontalBig,
                  ],
                ),
              ),

              IconButton(
                onPressed: onTap,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: PreMedColorTheme().primaryColorRed,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class NotesTileWithoutDescription extends StatelessWidget {
  const NotesTileWithoutDescription({
    super.key,
    required this.heading,
    required this.icon,
    this.bgColor = Colors.black12,
    this.btnColor = Colors.black,
    required this.onTap,
  });

  final String heading;
  final String icon;
  final Color bgColor;
  final Color btnColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: PreMedColorTheme().white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                icon,
                fit: BoxFit.contain,
                width: 60,
                height: 60,
              ),
              SizedBoxes.horizontalMedium,
              Expanded(
                child: Column(
                  children: [
                    SizedBoxes.horizontalMedium,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        heading,
                        style: PreMedTextTheme().heading5.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBoxes.horizontalBig,
                  ],
                ),
              ),
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: PreMedColorTheme().primaryColorRed,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}