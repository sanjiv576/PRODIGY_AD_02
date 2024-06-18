import 'package:flutter/material.dart';
import '../constants/color_constant.dart';

class KTextThemes {
  KTextThemes._();

  static TextTheme darkTextTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: KColors.darkTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.darkTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.darkTextColor,
      ),
      labelLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: KColors.darkTextColor,
      ),
      labelMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.darkTextColor,
      ),
      labelSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.darkTextColor,
      ),
    );
  }

  static TextTheme lightTextTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: KColors.lightTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.lightTextColor,
      ),
      titleSmall: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.lightTextColor,
      ),
      labelLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: KColors.lightTextColor,
      ),
      labelMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.lightTextColor,
      ),
      labelSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        color: KColors.lightTextColor,
      ),
    );
  }
}
