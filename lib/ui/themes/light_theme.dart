import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData lightThemeApp = ThemeData(
  useMaterial3: true,

  // ColorScheme ////////////////////////////////
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.black,
    secondary: AppColors.secondary,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: AppColors.white,
    onSurface: AppColors.secondary,
  ),

  // NavigationRailTheme ////////////////////////////////
  navigationRailTheme: NavigationRailThemeData(
    selectedLabelTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelTextStyle: TextStyle(color: AppColors.lightGrey),
    unselectedIconTheme: IconThemeData(color: AppColors.lightGrey),
    backgroundColor: AppColors.navigationRailBackground,
  ),
);
