import 'package:flutter/material.dart';

class AppTheme {
  /*static final lightTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.ligthBg,
        onPrimary: AppColors.darkBg,
        secondary: AppColors.primaryAuth,
        onSecondary: AppColors.ligthBg,
        error: AppColors.tertiaryAuth,
        onError: AppColors.errorBg,
        surface: AppColors.primaryBg,
        onSurface: AppColors.tertiaryAuth),
  );*/
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    hintColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 20),
    ),
  );

  /*static final darkTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.darkBg,
        onPrimary: AppColors.darkBg,
        secondary: AppColors.primaryAuth,
        onSecondary: AppColors.ligthBg,
        error: AppColors.tertiaryAuth,
        onError: AppColors.errorBg,
        surface: AppColors.primaryBg,
        onSurface: AppColors.tertiaryAuth),
  );*/
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    hintColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueAccent,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}
