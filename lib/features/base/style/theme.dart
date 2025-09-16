import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:flutter/material.dart';

ThemeData themeLight(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: AppColor.onPrimary,
      colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          onPrimary: AppColor.onPrimary,
          secondary: AppColor.secondary,
          onSecondary: AppColor.onSecondary,
          surface: AppColor.surface,
          onSurface: AppColor.onPrimary,
          error: AppColor.error,
          onError: AppColor.onError),
      dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(color: AppColor.textColor)));
}
