import 'package:premedpk_mobile_app/constants/constants_export.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.options = const [],
    this.value,
    this.onChanged,
    this.isDense = false,
    this.filled = false,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.enabledBorder,
    this.focusedBorder,
    this.contentPadding,
    this.style,
    this.errorText,
    this.errorStyle,
    this.hintText,
    this.hintStyle,
    this.onTap,
    this.validator,
  });

  final List<CustomDropDownOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool? isDense;
  final bool? filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final String? errorText;
  final TextStyle? errorStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final void Function()? onTap;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(8),
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        dropdownColor: PreMedColorTheme().white,
        borderRadius: BorderRadius.circular(8),
        icon: Icon(
          Icons.expand_more,
          color: PreMedColorTheme().neutral900,
        ),
        items: options.map((option) {
          return DropdownMenuItem(
              value: option.value,
              child: Text(
                option.displayOption,
                overflow: TextOverflow.ellipsis,
              ));
        }).toList(),
        // items: [],
        decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: PreMedColorTheme().white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: PreMedColorTheme().neutral900,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          isDense: isDense,
          contentPadding:
              contentPadding ?? const EdgeInsets.fromLTRB(16, 16, 16, 16),
          errorText: errorText,
          errorStyle: errorStyle,
          hintText: hintText,
          hintStyle: hintStyle ?? PreMedTextTheme().subtext,
        ),
        style: style ?? PreMedTextTheme().subtext,
        value: value,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

class CustomDropDownOption<T> {
  const CustomDropDownOption({
    required this.value,
    required this.displayOption,
  });
  final T value;
  final String displayOption;
}
