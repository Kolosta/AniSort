import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const primaryLight = Color(0xFF5F8AF9);
  static const primaryDark = Color(0xFF1A248E);
  // static const primaryLight = Color(0xFF8990D6);
  // static const primaryDark = Color(0xFF5ACD57);

  static const onPrimaryLight = Color(0xFFFFFFFF);
  static const onPrimaryDark = Color(0xFFFFFFFF);

  static const secondaryLight = Color(0xFFF95F8A);
  static const secondaryDark = Color(0xFFE8467C);

  static const tertiaryLight = Color(0xFF8AF95F);
  static const tertiaryDark = Color(0xFF488C2F);

  static const errorLight = Color(0xFFB00020);
  static const errorDark = Color(0xFFCF6679);

  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF121212);

  static const onSurfaceLight = Color(0xFF000000);
  static const onSurfaceDark = Color(0xFFFFFFFF);
  static const onSurfaceVariantLight = Color(0xFF303030);
  static const onSurfaceVariantDark = Color(0xFF838383);

  static const outlineLight = Color(0xFF6E6E6E);
  static const outlineDark = Color(0xFFBDBDBD);
}

extension AppColorExtension on Color {
  Color get withOpacity10 => withOpacity(0.1);
  Color get withOpacity20 => withOpacity(0.2);
  Color get withOpacity30 => withOpacity(0.3);
  Color get withOpacity40 => withOpacity(0.4);
  Color get withOpacity50 => withOpacity(0.5);
  Color get withOpacity60 => withOpacity(0.6);
  Color get withOpacity70 => withOpacity(0.7);
  Color get withOpacity80 => withOpacity(0.8);
  Color get withOpacity90 => withOpacity(0.9);
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  primary: AppColor.primaryLight,
  onPrimary: AppColor.onPrimaryLight,

  secondary: AppColor.secondaryLight,
  onSecondary: AppColor.onPrimaryLight,

  surface: AppColor.surfaceLight,
  onSurface: AppColor.onSurfaceLight,
  onSurfaceVariant: AppColor.onSurfaceVariantLight,

  outline: AppColor.outlineLight,

  error: AppColor.errorLight,
  onError: AppColor.onPrimaryLight,

);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  primary: AppColor.primaryDark,
  onPrimary: AppColor.onPrimaryDark,

  secondary: AppColor.secondaryDark,
  onSecondary: AppColor.onPrimaryDark,

  surface: AppColor.surfaceDark,
  onSurface: AppColor.onSurfaceDark,
  onSurfaceVariant: AppColor.onSurfaceVariantDark,

  outline: AppColor.outlineDark,

  error: AppColor.errorDark,
  onError: AppColor.onPrimaryDark,
);

