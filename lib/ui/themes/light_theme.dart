import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData lightThemeApp = ThemeData(
  useMaterial3: true,

  // ColorScheme ////////////////////////////////
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.darkPrimaryText,
    onPrimary: AppColors.darkPrimaryText,
    secondary: AppColors.primary,
    onSecondary: AppColors.darkPrimaryText,
    error: Colors.red,
    onError: Colors.white,
    surface: AppColors.darkPrimaryText,
    onSurface: AppColors.primary,
  ),

  // TextTheme ////////////////////////////////
  textTheme: TextTheme(
    bodySmall: TextStyle(color: AppColors.darkSecondaryText),
    bodyMedium: TextStyle(color: AppColors.darkPrimaryText),
    bodyLarge: TextStyle(
      color: AppColors.darkSecondaryText, // TextField
    ),
  ),

    // SnackBarTheme ////////////////////////////////
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.primary,
    contentTextStyle: TextStyle(color: AppColors.darkPrimaryText),
  ),

  // ElevatedButtonTheme ////////////////////////////////
  elevatedButtonTheme: const ElevatedButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(AppColors.primary),
      backgroundColor: WidgetStatePropertyAll(AppColors.black),
    ),
  ),

  // NavigationRailTheme ////////////////////////////////
  navigationRailTheme: const NavigationRailThemeData(
    selectedLabelTextStyle: TextStyle(
      color: AppColors.darkPrimaryText,
      fontWeight: FontWeight.bold,
    ),
    selectedIconTheme: IconThemeData(color: AppColors.darkPrimaryText),
    unselectedLabelTextStyle: TextStyle(color: AppColors.secondary),
    unselectedIconTheme: IconThemeData(color: AppColors.secondary),
    backgroundColor: Color.fromARGB(255, 155, 155, 155),
  ),
);
