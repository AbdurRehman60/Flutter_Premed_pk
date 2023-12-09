import 'package:premedpk_mobile_app/constants/constants_export.dart';

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
    this.fontSize = 20.0,
    this.leftIcon = true,
    this.color,
    this.textColor,
  }) : super(key: key);

  String buttonText;
  final Function()? onPressed;
  Size buttonSize = const Size(0, 0);
  final bool isActive;
  final bool isOutlined;
  final bool isIconButton;
  final IconData icon;
  final double iconSize;
  final bool leftIcon;
  final Color? color;
  final Color? textColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    buttonSize = Size(MediaQuery.of(context).size.width * 1, 54);
    return isOutlined
        ? TextButton(
            onPressed: isActive ? onPressed ?? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive
                  ? PreMedColorTheme().white
                  : PreMedColorTheme().primaryColorRed,
              side: BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: PreMedColorTheme().neutral400),
              minimumSize: buttonSize,
            ),
            child: isIconButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      leftIcon
                          ? Icon(
                              icon,
                              size: iconSize,
                              color: isOutlined
                                  ? textColor ??
                                      PreMedColorTheme().primaryColorRed
                                  : textColor ?? PreMedColorTheme().white,
                            )
                          : const SizedBox(),
                      leftIcon ? SizedBoxes.horizontalMicro : const SizedBox(),
                      Text(
                        buttonText,
                        style: isActive
                            ? PreMedTextTheme().heading5.copyWith(
                                color: textColor ??
                                    PreMedColorTheme().primaryColorRed,
                                fontSize: fontSize ?? 20)
                            : PreMedTextTheme().heading6.copyWith(
                                color: PreMedColorTheme().primaryColorRed),
                      ),
                      leftIcon ? const SizedBox() : SizedBoxes.horizontalMicro,
                      leftIcon
                          ? const SizedBox()
                          : Icon(
                              icon,
                              size: iconSize,
                              color: isOutlined
                                  ? textColor ?? PreMedColorTheme().neutral800
                                  : textColor ?? PreMedColorTheme().white,
                            ),
                    ],
                  )
                : Text(
                    buttonText,
                    style: isActive
                        ? PreMedTextTheme().heading6.copyWith(
                            color: textColor ?? PreMedColorTheme().white,
                            fontSize: fontSize ?? 20)
                        : PreMedTextTheme().heading6.copyWith(
                            color: PreMedColorTheme().primaryColorRed,
                            fontSize: fontSize ?? 20),
                  ),
          )
        : TextButton(
            onPressed: isActive ? onPressed ?? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: isActive
                  ? color ?? PreMedColorTheme().primaryColorRed
                  : PreMedColorTheme().neutral700,
              minimumSize: buttonSize,
            ),
            child: isIconButton
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      leftIcon
                          ? Icon(
                              icon,
                              size: iconSize,
                              color: isOutlined
                                  ? textColor ??
                                      PreMedColorTheme().primaryColorRed
                                  : textColor ?? PreMedColorTheme().white,
                            )
                          : const SizedBox(),
                      leftIcon ? SizedBoxes.horizontalMicro : const SizedBox(),
                      Text(
                        buttonText,
                        style: isActive
                            ? PreMedTextTheme().heading6.copyWith(
                                color: textColor ?? PreMedColorTheme().white,
                                fontSize: fontSize ?? 20)
                            : PreMedTextTheme().heading6.copyWith(
                                color: textColor ??
                                    PreMedColorTheme().primaryColorRed,
                                fontSize: fontSize ?? 20),
                      ),
                      leftIcon ? const SizedBox() : SizedBoxes.horizontalMicro,
                      leftIcon
                          ? const SizedBox()
                          : Icon(
                              icon,
                              size: iconSize,
                              color: isOutlined
                                  ? textColor ??
                                      PreMedColorTheme().primaryColorRed
                                  : textColor ?? PreMedColorTheme().white,
                            ),
                    ],
                  )
                : Text(
                    buttonText,
                    style: isActive
                        ? PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white)
                        : PreMedTextTheme().heading6.copyWith(
                            color: PreMedColorTheme().primaryColorRed),
                  ),
          );
  }
}
