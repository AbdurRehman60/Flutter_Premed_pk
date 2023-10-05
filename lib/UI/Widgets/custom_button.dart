import 'package:premedpk_mobile_app/export.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.isActive = true,
    this.isOutlined = false,
    this.isIconButton = false,
    this.icon = Icons.abc,
    this.iconSize = 24.0,
  }) : super(key: key);

  String buttonText;
  final Function onPressed;
  Size buttonSize = const Size(0, 0);
  final bool isActive;
  final bool isOutlined;
  final bool isIconButton;
  final IconData icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    buttonSize = Size(MediaQuery.of(context).size.width * 1, 60);
    return isOutlined
        ? TextButton(
            onPressed: isActive
                ? () {
                    onPressed();
                  }
                : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive
                  ? PreMedColorTheme().standardwhite
                  : PreMedColorTheme().primaryColorRed,
              side: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: PreMedColorTheme().primaryColorRed),
              minimumSize: buttonSize,
            ),
            child: Text(
              buttonText,
              style: isActive
                  ? PreMedTextTheme()
                      .title
                      .copyWith(color: PreMedColorTheme().primaryColorRed)
                  : PreMedTextTheme()
                      .title
                      .copyWith(color: PreMedColorTheme().primaryColorRed),
            ),
          )
        : TextButton(
            onPressed: isActive
                ? () {
                    onPressed();
                  }
                : () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive
                  ? PreMedColorTheme().primaryColorRed
                  : PreMedColorTheme().primaryColorRed,
              minimumSize: buttonSize,
            ),
            child: isIconButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: iconSize,
                        color: isOutlined
                            ? PreMedColorTheme().primaryColorRed
                            : PreMedColorTheme().standardwhite,
                      ),
                      SizedBoxes.horizontalMicro,
                      Text(
                        buttonText,
                        style: isActive
                            ? PreMedTextTheme().title.copyWith(
                                color: PreMedColorTheme().standardwhite)
                            : PreMedTextTheme().title.copyWith(
                                color: PreMedColorTheme().primaryColorRed),
                      ),
                    ],
                  )
                : Text(
                    buttonText,
                    style: isActive
                        ? PreMedTextTheme()
                            .title
                            .copyWith(color: PreMedColorTheme().standardwhite)
                        : PreMedTextTheme().title.copyWith(
                            color: PreMedColorTheme().primaryColorRed),
                  ),
          );
  }
}
