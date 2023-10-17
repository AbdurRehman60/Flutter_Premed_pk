import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:premedpk_mobile_app/export.dart';

class PreMedTheme {
  final PreMedColorTheme _ColorTheme;
  final PreMedTextTheme _TextTheme;

  PreMedTheme({
    PreMedColorTheme? ColorTheme,
    PreMedTextTheme? TextTheme,
  })  : _TextTheme = TextTheme ?? PreMedTextTheme(),
        _ColorTheme = ColorTheme ?? PreMedColorTheme();

  ThemeData get data => ThemeData(
        primaryColor: _ColorTheme.primaryColorRed,
        fontFamily: _TextTheme.fontFamily,
        colorScheme: colorScheme,
        appBarTheme: appBarTheme,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: textButtonThemeData,
        tabBarTheme: tabBarTheme,
      );

  ColorScheme get colorScheme => const ColorScheme.light().copyWith(
        primary: _ColorTheme.primaryColorRed,
        secondary: _ColorTheme.primaryColorBlue,
        background: _ColorTheme.black,
        surface: _ColorTheme.white,
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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(20, 0, 0, 0),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
        elevation: 0,
      );

  TabBarTheme get tabBarTheme => TabBarTheme(
        labelColor:
            PreMedColorTheme().white, // Color for the selected tab label
        unselectedLabelColor: Colors.black54, // Color for unselected tab labels
        labelStyle: PreMedTextTheme().body.copyWith(
              fontWeight: FontWeights.bold,
            ), // Style for selected tab label
        unselectedLabelStyle: PreMedTextTheme().body.copyWith(
              fontWeight: FontWeights.medium,
            ),
        indicatorColor: PreMedColorTheme().white,
        dividerColor: Colors.white,

        // Style for unselected tab labels
      );
}
