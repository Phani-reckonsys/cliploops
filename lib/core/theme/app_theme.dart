// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'GT Walsheim Trial', 

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black, // For text and icons
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark icons for light status bar
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'GT Walsheim Trial', 

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white, // For text and icons
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light, // Light icons for dark status bar
    ),
  );
}