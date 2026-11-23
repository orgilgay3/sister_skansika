import 'package:flutter/material.dart';

class AppColors {
  static const teal = Color(0xFF087F8C);
  static const tealSoft = Color(0xFFE6F4F4);
  static const background = Color(0xFFF5F5FA);
  static const ink = Color(0xFF1B2038);
  static const muted = Color(0xFF6B7088);
  static const blue = Color(0xFF3B5598);
  static const blueSoft = Color(0xFFECF0FA);
  static const green = Color(0xFF1FA67A);
  static const greenSoft = Color(0xFFDDF5EB);
  static const amber = Color(0xFFE0A030);
  static const amberSoft = Color(0xFFFCF1DC);
  static const red = Color(0xFFD64545);
  static const border = Color(0xFFE8E8F0);
}

ThemeData buildTheme() {
  final radius = BorderRadius.circular(14);
  OutlineInputBorder border(Color c) =>
      OutlineInputBorder(borderRadius: radius, borderSide: BorderSide(color: c));

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teal),
    scaffoldBackgroundColor: AppColors.background,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
      labelStyle: const TextStyle(color: AppColors.muted, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.teal),
      errorBorder: border(AppColors.red),
      focusedErrorBorder: border(AppColors.red),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.teal,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.border,
        elevation: 0,
        minimumSize: const Size.fromHeight(56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      height: 64,
      labelTextStyle: WidgetStateProperty.resolveWith((s) {
        final sel = s.contains(WidgetState.selected);
        return TextStyle(
          fontSize: 10.5,
          fontWeight: sel ? FontWeight.w800 : FontWeight.w500,
          color: sel ? AppColors.teal : AppColors.muted,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((s) {
        final sel = s.contains(WidgetState.selected);
        return IconThemeData(
          size: 22,
          color: sel ? AppColors.teal : AppColors.muted,
        );
      }),
    ),
  );
}