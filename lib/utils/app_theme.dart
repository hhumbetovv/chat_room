import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    splashFactory: InkSparkle.splashFactory,
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(splashFactory: InkSparkle.splashFactory),
    ),
    scaffoldBackgroundColor: AppColors.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.active,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.active,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.active,
    ),
  );
}
