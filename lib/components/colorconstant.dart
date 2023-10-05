import 'package:premedpk_mobile_app/export.dart';

class PreMedColorTheme {
  var title;

  Color get primaryColorRed600 => const Color(0xFF8E353B);
  Color get primaryColorRed500 => const Color(0xFFBD464F);
  Color get primaryColorRed => const Color(0xFFEC5863);
  Color get primaryColorRed300 => const Color(0xFFF07982);
  Color get primaryColorRed200 => const Color(0xFFF49BA1);
  //now list of primary blue colors
  Color get primaryColorBlue600 => const Color(0xFF567099);
  Color get primaryColorBlue500 => const Color(0xFF7395CC);
  Color get primaryColorBlue => const Color(0xFF8FB9FF);
  Color get primaryColorBlue300 => const Color(0xFFA6C8FF);
  Color get primaryColorBlue200 => const Color(0xFFBCD6FF);
  //normal color list
  Color get standardwhite => const Color(0xFFFFFFFF);
  Color get standardblack => const Color(0xFF000000);
  Color get neutral50 => const Color(0xFFFAFAFA);
  Color get neutral100 => const Color(0xFFF4F4F5);
  Color get neutral200 => const Color(0xFFE3E3E7);
  Color get neutral300 => const Color(0xFFD4D4D8);
  Color get neutral400 => const Color(0xFFA1A1AA);
  Color get neutral500 => const Color(0xFF71717A);
  Color get neutral600 => const Color(0xFF52525B);
  Color get neutral700 => const Color(0xFF3E3E46);
  Color get neutral800 => const Color(0xFF27272A);
  Color get neutral900 => const Color(0xFF17171B);
  //gradientcolors
  LinearGradient get primaryGradient => LinearGradient(
        colors: [primaryColorRed, primaryColorBlue],
      );
}
