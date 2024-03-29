import 'package:cocktalez/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    brightness: Brightness.light,
    disabledColor: AppColors.disabled,
    cardTheme: const CardTheme(
      color: AppColors.cardLight,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.backgroundLight,
      iconTheme: const IconThemeData(
        color: AppColors.textLight,
      ),
      titleTextStyle: GoogleFonts.openSans(
        color: AppColors.textLight,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.iconTint,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.iconTint,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.primary.withOpacity(0.15),
      ),
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16.0,
      ),
    ),
    primaryTextTheme: TextTheme(
      displayLarge: const TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.bold,
        fontSize: 28.0,
      ),
      displayMedium: const TextStyle(
        color: AppColors.textLight,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
      titleMedium: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 36.0,
      ),
      bodyLarge: const TextStyle(
        color: AppColors.textLight,
        fontSize: 16.0,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textLight.withOpacity(0.7),
        fontSize: 14.0,
      ),
      labelLarge: const TextStyle(
        color: AppColors.textLight,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    brightness: Brightness.dark,
    disabledColor: AppColors.disabled,
    cardTheme: const CardTheme(
      color: AppColors.cardDark,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.backgroundDark,
      iconTheme: IconThemeData(
        color: AppColors.textDark,
      ),
      titleTextStyle: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.iconTint,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.iconTint,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.primary.withOpacity(0.15),
      ),
      labelStyle: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16.0,
      ),
    ),
    primaryTextTheme: TextTheme(
      displayLarge: const TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
        fontSize: 28.0,
      ),
      displayMedium: const TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
      titleMedium: const TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 36.0,
      ),
      bodyLarge: const TextStyle(
        color: AppColors.textDark,
        fontSize: 16.0,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textDark.withOpacity(0.7),
        fontSize: 14.0,
      ),
      labelLarge: const TextStyle(
        color: AppColors.textDark,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
