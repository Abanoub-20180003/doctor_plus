import 'package:flutter/material.dart';
import 'package:doctor_plus/View/Style/color_manager.dart';

abstract class ThemeManager {
  static ThemeData getAppTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.primaryColor,
      primaryColor: ColorManager.primaryColor,
      colorScheme: ColorScheme.dark(primary: ColorManager.white),
      appBarTheme: AppBarTheme(
        color: ColorManager.primaryColor,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
