import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import 'text_theme.dart';

class AppThemes {
  static appLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      textTheme: KTextThemes.lightTextTheme(),
      fontFamily: 'WorkSans',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 5.0,
          backgroundColor: KColors.lightButtonColor, // button background color

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  static appDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      textTheme: KTextThemes.darkTextTheme(),
      fontFamily: 'WorkSans',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 5.0,
          backgroundColor: KColors.darkButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
