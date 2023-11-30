import 'package:flutter/material.dart';
import 'package:nanny_app/core/utils/color_utils.dart';

class CustomTheme {
  static const double horizontalPadding = 16;
  static const double pageTopPadding = 24;
  static const double cardPadding = 16;
  static const double borderRadius = 4;
  static const double cardBorderRadius = 8;
  static const double cardBottomMargin = 16;

  static MaterialColor primaryColor = const Color(0xFF1A0DB3).materialColor;

  static MaterialColor grey = const Color(0xFF9CA1A7).materialColor;
  static MaterialColor green = const Color(0xFFBEFF33).materialColor;
  static MaterialColor secondaryColor = const Color(0xFFEEECFF).materialColor;
  static MaterialColor backgroundColor = const Color(0xFFF5F5F5).materialColor;
  static MaterialColor lightGreen = const Color(0xFFEBFCF7).materialColor;
  static MaterialColor greentext = const Color(0xFF06D496).materialColor;
  static MaterialColor yellowLight = const Color(0xFFFFF9E2).materialColor;
  static MaterialColor yellow = const Color(0xFFFFD233).materialColor;
  static MaterialColor lightBlue = const Color(0xFFCEE8FF).materialColor;
  static MaterialColor tableHead = const Color(0xFFF0E5FF).materialColor;
  static MaterialColor blue = const Color(0xFF1A0DB3).materialColor;
  static const Color borderColor = Color(0xFFD9D9D9);

  static MaterialColor red = const Color(0xFFFF3358).materialColor;

  static Color textColor = Colors.black;

  static BoxShadow shadow1 = BoxShadow(
    offset: const Offset(0, 4),
    color: CustomTheme.grey.withOpacity(0.1),
    blurRadius: 10,
  );
}

extension on Color {
  MaterialColor get materialColor =>
      ColorUtils.generateMaterialColor(color: this);
}
