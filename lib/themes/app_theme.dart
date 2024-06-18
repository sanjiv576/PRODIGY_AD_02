import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import 'text_theme.dart';

class AppThemes {
  static appLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: KTextThemes.lightTextTheme(),
      buttonTheme: ButtonThemeData(
        buttonColor: KColors.lightButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static appDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: KTextThemes.darkTextTheme(),
      fontFamily: 'Roboto',
      buttonTheme: const ButtonThemeData(
        buttonColor: KColors.darkButtonColor,
        splashColor: Colors.yellow,
      ),
    );
  }
}
