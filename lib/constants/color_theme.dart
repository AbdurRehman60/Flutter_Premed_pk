import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PreMedColorTheme {
  Color get primaryColorRed600 => const Color(0xFF8E353B);

  Color get primaryColorRed500 => const Color(0xFFBD464F);

  Color get primaryColorRed => const Color(0xFFEC5863);

  Color get primaryColorRed300 => const Color(0xFFF07982);

  Color get primaryColorRed200 => const Color(0xFFF49BA1);

  Color get primaryColorRed100 => const Color(0xFFFFE8E9);

  Color get primaryColorRedLighter => const Color(0xFFFFFBFB);

  Color get primaryColorRed800 => const Color(0xFF2F1214);

  Color get bordercolor => const Color(0xFFC30052);

  Color get roundbutton => const Color(0xFFFCEBF8);

  //now list of primary blue colors
  Color get primaryColorBlue600 => const Color(0xFF567099);

  Color get primaryColorBlue500 => const Color(0xFF7395CC);

  Color get primaryColorBlue => const Color(0xFF8FB9FF);

  Color get primaryColorBlue300 => const Color(0xFFA6C8FF);

  Color get primaryColorBlue200 => const Color(0xFFBCD6FF);

  Color get primaryColorBlue100 => const Color(0xFFE9F1FF);

  Color get primaryColorBlue800 => const Color(0xFF1D2533);

  //checkbox color
  Color customCheckboxColor = const Color(0xFF77D9A5);
  Color tickcolor = const Color(0xFF076445);
  Color highschoolblue = const Color(0xFF4285F4);
  Color customclr1 = const Color(0xFFE4E9FD);

  //normal color list
  Color get white => const Color(0xFFFFFFFF);

  Color get black => const Color(0xFF000000);

  //Neutral Colors
  Color get neutral50 => const Color(0xFFFAFAFA);

  Color get neutral60 => const Color(0xFFFFF6FB);

  Color get neutral100 => const Color(0xFFF4F4F5);

  Color get neutral200 => const Color(0xFFE3E3E7);

  Color get neutral300 => const Color(0xFFD4D4D8);

  Color get neutral400 => const Color(0xFFA1A1AA);

  Color get neutral500 => const Color(0xFF71717A);

  Color get neutral600 => const Color(0xFF52525B);

  Color get neutral700 => const Color(0xFF3E3E46);

  Color get neutral800 => const Color(0xFF27272A);

  Color get neutral900 => const Color(0xFF17171B);
  Color get neutral650 => const Color(0xFF6E6E6E);
  Color get white85 => Colors.white.withOpacity(0.8500000238418579);

  Color get green => const Color.fromARGB(1, 43, 177, 64);

  Color get background => const Color(0xFFFBF0F3);
  Color get yellowlight => const Color(0xFFFFC372);
  Color get greenLight => const Color(0xFF60CDBB);
  Color get purpulelight => const Color(0xFF8800C3);
  Color get orangeLight => const Color(0xFFFB9666);
  Color get redlight => const Color(0xFFC40052);
  Color get greenL => const Color(0xFF42C96B);
  Color get skyblue => const Color(0xFF0383BB);
  Color get red => const Color(0xFFEC5863);
  Color get coolBlue => const Color(0xFF2370CA);
  Color get blue => const Color(0xFF4285F4);

  //Gradient colors
  LinearGradient get primaryGradient => LinearGradient(
        colors: [primaryColorBlue, primaryColorRed],
      );

  LinearGradient get primaryRedGradient => LinearGradient(
        colors: [primaryColorRed, primaryColorRed500],
      );

  LinearGradient get primaryBlueGradient => LinearGradient(
        colors: [primaryColorBlue600, primaryColorBlue],
      );

  LinearGradient get primaryGradient1 => LinearGradient(
        colors: [primaryColorBlue600, primaryColorRed],
      );

  LinearGradient get doctorcont => LinearGradient(
        colors: [white, customclr1],
      );
}
