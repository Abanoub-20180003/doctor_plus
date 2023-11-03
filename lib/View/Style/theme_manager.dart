import 'package:flutter/material.dart';
import 'package:doctor_plus/View/Style/color_manager.dart';

import '../Layout/colors.dart';

abstract class ThemeManager {
  static ThemeData getAppDarkTheme() {
    return ThemeData(
      backgroundColor:ColorManager.primaryColor ,
      bottomNavigationBarTheme:BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(color: secondColor),
          unselectedLabelStyle: TextStyle(color: thirdColor),

      ) ,
      scaffoldBackgroundColor: ColorManager.primaryColor,
      primaryColor: ColorManager.primaryColor,
     colorScheme: ColorScheme.dark(primary: ColorManager.white , background:ColorManager.black, ),
      appBarTheme: AppBarTheme(
        backgroundColor:ColorManager.primaryColor,
        //color: ColorManager.primaryColor,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData getAppLightTheme() {
    return ThemeData(
      bottomNavigationBarTheme:BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        unselectedItemColor: defaultColor,
        selectedLabelStyle: TextStyle(color: secondColor),
        unselectedLabelStyle: TextStyle(color: ColorManager.black),

      ) ,
      scaffoldBackgroundColor: ColorManager.white,
      primaryColor: ColorManager.white,
      colorScheme: ColorScheme.light(primary: ColorManager.black),
      appBarTheme: AppBarTheme(
        color: defaultColor,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24 ,color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
