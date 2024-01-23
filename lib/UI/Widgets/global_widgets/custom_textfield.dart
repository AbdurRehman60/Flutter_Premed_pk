import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class CustomTextField extends StatefulWidget {
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
    this.inputFormatters,
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
  final List<TextInputFormatter>? inputFormatters;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          enabled: widget.enabled,
          initialValue: widget.initialValue,
          obscureText: _obscureText,
          decoration: InputDecoration(
            filled: widget.filled,
            fillColor: widget.fillColor,
            border: widget.border,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: PreMedColorTheme().neutral200,
              ),
            ),
            enabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: PreMedColorTheme().neutral600,
                  ),
                ),
            focusedBorder: widget.focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: PreMedColorTheme().black,
                  ),
                ),
            errorBorder: widget.errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red),
                ),
            focusedErrorBorder: widget.focusedErrorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red),
                ),
            errorText: widget.errorText,
            errorStyle: widget.errorStyle,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                PreMedTextTheme()
                    .subtext
                    .copyWith(color: PreMedColorTheme().neutral400),
            isDense: widget.isDense,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.fromLTRB(16, 16, 16, 16),
            suffixIconConstraints: widget.suffixIconConstraints,
            labelText: widget.labelText,
            labelStyle: widget.enabled
                ? widget.labelStyle ?? PreMedTextTheme().subtext
                : PreMedTextTheme()
                    .subtext
                    .copyWith(color: PreMedColorTheme().neutral400),
            alignLabelWithHint: widget.alignLabelWithText,
          ),
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          controller: widget._controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          style: widget.contentStyle ?? PreMedTextTheme().subtext,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          inputFormatters: widget.inputFormatters,
        ),
        if (widget.obscureText)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
      ],
    );
  }
}
