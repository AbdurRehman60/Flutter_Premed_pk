// ignore_for_file: non_constant_identifier_names

import 'package:premedpk_mobile_app/constants/constants_export.dart';

class PreMedTheme {
  PreMedTheme({
    PreMedColorTheme? ColorTheme,
    PreMedTextTheme? TextTheme,
  })  : _TextTheme = TextTheme ?? PreMedTextTheme(),
        _ColorTheme = ColorTheme ?? PreMedColorTheme();
  final PreMedColorTheme _ColorTheme;
  final PreMedTextTheme _TextTheme;

  ThemeData get data => ThemeData(
        primaryColor: _ColorTheme.primaryColorRed,
        fontFamily: _TextTheme.fontFamily,
        colorScheme: colorScheme,
        appBarTheme: appBarTheme,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: textButtonThemeData,
        tabBarTheme: tabBarTheme,
        useMaterial3: true,
      );

  ColorScheme get colorScheme => const ColorScheme.light().copyWith(
        primary: _ColorTheme.primaryColorRed,
        secondary: _ColorTheme.primaryColorBlue,
        background: _ColorTheme.white,
        surface: _ColorTheme.white,
        surfaceTint: _ColorTheme.neutral100,
      );

  TextButtonThemeData get textButtonThemeData => TextButtonThemeData(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(const Color.fromARGB(18, 0, 0, 0)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      );

  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: _ColorTheme.primaryColorRed,
        foregroundColor: _ColorTheme.white,
        iconTheme: IconThemeData(
          color: PreMedColorTheme().white,
        ),
      );

  TabBarTheme get tabBarTheme => TabBarTheme(
        labelColor: PreMedColorTheme().white,
        unselectedLabelColor: Colors.black54,
        labelStyle: PreMedTextTheme().body.copyWith(
              fontWeight: FontWeights.bold,
            ),
        unselectedLabelStyle: PreMedTextTheme().body.copyWith(
              fontWeight: FontWeights.medium,
            ),
        indicatorColor: PreMedColorTheme().white,
        dividerColor: Colors.white,
      );
}
