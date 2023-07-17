import 'package:dubai_sdk_kotlin/resources/strings/app_strings.dart';
import 'package:dubai_sdk_kotlin/style/app_colors.dart';
import 'package:flutter/material.dart';

final MaterialColor kPrimaryColor = MaterialColor(
  AppColors.primary.value,
  const <int, Color>{
    50: AppColors.primary,
    100: AppColors.primary,
    200: AppColors.primary,
    300: AppColors.primary,
    400: AppColors.primary,
    500: AppColors.primary,
    600: AppColors.primary,
    700: AppColors.primary,
    800: AppColors.primary,
    900: AppColors.primary,
  },
);

class Themes {
  static ThemeData appThemeLight() {
    return ThemeData(
      primarySwatch: kPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      //buttonColor: AppColors.primary,
      dividerColor: Colors.transparent,
      appBarTheme: AppBarTheme(
      // brightness: Brightness.dark
      )
    );
  }
}
