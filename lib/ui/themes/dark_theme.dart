import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData darkThemeApp = ThemeData(
  useMaterial3: true,

  // ColorScheme ////////////////////////////////
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: AppColors.background,
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
