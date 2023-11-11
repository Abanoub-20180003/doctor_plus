import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

abstract class ColorManager {
  static Color primaryColor = HexColor('203f64');
  static Color white = Colors.white;
  static Color black = Color(0xFF333739);
  static Color lightBlack = Colors.black.withOpacity(0.25);
  static Color meduimBlack = Colors.black.withOpacity(0.55);
  static Color grey = Colors.grey.withOpacity(0.8);
  static Color transparent = Colors.transparent;
  static Color lightGrey = Colors.grey.withOpacity(0.2);
  static Color red = Colors.red;
}
