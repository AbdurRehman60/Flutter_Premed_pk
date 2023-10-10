import 'package:premedpk_mobile_app/export.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    TextEditingController? controller,
    this.initialValue,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.suffixIconConstraints,
    this.errorText,
    this.errorStyle,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.isDense = true,
    this.readOnly = false,
    this.alignLabelWithText,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.border,
    this.contentPadding,
    this.contentStyle,
    this.enabled = true,
    this.validator,
    this.cursorColor,
    required Null Function() onPressed,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final String? initialValue;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final BoxConstraints? suffixIconConstraints;
  final String? errorText;
  final TextStyle? errorStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool isDense;
  final bool readOnly;
  final bool? alignLabelWithText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentStyle;
  final MouseCursor? cursorColor;
  final String? Function(String?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        border: border,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: PreMedColorTheme().black,
          ),
        ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: PreMedColorTheme().black,
              ),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: PreMedColorTheme().black,
              ),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
        errorText: errorText,
        errorStyle: errorStyle,
        hintText: hintText,
        hintStyle: hintStyle ??
            PreMedTextTheme()
                .subtext
                .copyWith(color: PreMedColorTheme().neutral400),
        isDense: isDense,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 16),
        suffixIconConstraints: suffixIconConstraints,
        labelText: labelText,
        labelStyle: enabled
            ? labelStyle ?? PreMedTextTheme().subtext
            : PreMedTextTheme()
                .subtext
                .copyWith(color: PreMedColorTheme().neutral400),
        alignLabelWithHint: alignLabelWithText,
      ),
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: _controller,
      onChanged: onChanged,
      validator: validator,
      style: contentStyle ?? PreMedTextTheme().subtext,
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
