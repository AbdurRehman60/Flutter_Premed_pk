import 'package:premedpk_mobile_app/constants/constants_export.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.heading,
    required this.icon,
    required this.onTap,
    required this.padding,
  });
  final String heading;

  final String icon;

  final VoidCallback onTap;

  final double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: PreMedColorTheme().white),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    style: PreMedTextTheme()
                        .body
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              SizedBoxes.verticalLarge,
              Row(
                children: [
                  SizedBoxes.horizontalBig,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: PreMedColorTheme().primaryColorRed,
                    size: 20,
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

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.onTap, required this.userName});
  final void Function() onTap;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
              color: PreMedColorTheme().white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff26000000),
                  blurRadius: 40,
                  offset: Offset(0, 20),
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '@',
                      style: PreMedTextTheme().body1.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.red,
                          ),
                    ),
                    TextSpan(
                      text: userName,
                      style: PreMedTextTheme().body1.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: PreMedColorTheme().black,
                          ),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                'Account Details',
                style: PreMedTextTheme()
                    .body1
                    .copyWith(fontSize: 13, fontWeight: FontWeight.normal),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: PreMedColorTheme().primaryColorRed,
                size: 20,
              ),
            ),
          ),
        ));
  }
}
