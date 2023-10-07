import 'package:premedpk_mobile_app/export.dart';

class PreMedTextTheme {
  PreMedTextTheme({
    this.fontFamily = "Inter",
  }) : _baseTextStyle = TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeights.regular,
            height: 1.2,
            color: PreMedColorTheme().standardblack);

  final String fontFamily;
  final TextStyle _baseTextStyle;

  TextStyle get heading => _baseTextStyle.copyWith(
        fontSize: 36.0,
        fontWeight: FontWeights.semiBold,
      );

  TextStyle get heading2 => _baseTextStyle.copyWith(
        fontSize: 32.0,
        fontWeight: FontWeights.semiBold,
      );

  TextStyle get heading3 => _baseTextStyle.copyWith(
        fontSize: 28.0,
        fontWeight: FontWeights.semiBold,
      );

  TextStyle get title => _baseTextStyle.copyWith(
        fontSize: 24.0,
        fontWeight: FontWeights.semiBold,
      );

  TextStyle get body => _baseTextStyle.copyWith(
        fontSize: 28.0,
        fontWeight: FontWeights.semiBold,
      );

  TextStyle get subtext => _baseTextStyle.copyWith(
        fontSize: 18.0,
        fontWeight: FontWeights.semiBold,
      );
  TextStyle get small => _baseTextStyle.copyWith(
      fontSize: 16.0,
      fontWeight: FontWeights.regular,
      color: PreMedColorTheme().neutral400
      // color: PreMedColorTheme().standardwhite
      );
}

extension FontWeights on FontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
