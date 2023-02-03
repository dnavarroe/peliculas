import 'package:flutter/material.dart';

class AppTheme{

  static Color primary = Colors.green;

  
  static ThemeData appThemeLight = ThemeData.light().copyWith(
    primaryColor: primary,

    appBarTheme:  AppBarTheme(
      color: primary,
      elevation: 0,
    ),
    
  );

    static ThemeData appThemeDark = ThemeData.dark().copyWith(
    primaryColor: primary,

    appBarTheme:  AppBarTheme(
      color: primary,
      elevation: 0
    )
  );



}