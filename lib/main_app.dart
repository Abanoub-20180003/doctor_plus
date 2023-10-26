import 'package:flutter/material.dart';
import 'package:doctor_plus/View/Style/theme_manager.dart';

import 'View/Screens/LoginView/login.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.from(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
      //   ),
      // ),
      theme: ThemeManager.getAppTheme(),
      home: const Login(),
    );
  }
}
