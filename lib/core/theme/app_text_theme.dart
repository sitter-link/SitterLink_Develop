import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  TextStyle bodySmallRegular;
  TextStyle bodySmallMedium;
  TextStyle bodySmallSemiBold;
  TextStyle bodySmallBold;
  TextStyle bodyRegular;
  TextStyle bodyMedium;
  TextStyle bodySemiBold;
  TextStyle bodyBold;
  TextStyle bodyLargeRegular;
  TextStyle bodyLargeMedium;
  TextStyle bodyLargeSemiBold;
  TextStyle bodyLargeBold;
  TextStyle formLabel;
  TextStyle appTitle;
  TextStyle pageHeader;
  TextStyle button;
  TextStyle navBar;
  TextStyle formInput;

  AppTextTheme({
    required this.bodySmallRegular,
    required this.bodySmallMedium,
    required this.bodySmallSemiBold,
    required this.bodySmallBold,
    required this.bodyRegular,
    required this.bodyLargeRegular,
    required this.bodyLargeMedium,
    required this.bodyLargeSemiBold,
    required this.bodyLargeBold,
    required this.formLabel,
    required this.pageHeader,
    required this.navBar,
    required this.button,
    required this.appTitle,
    required this.bodyBold,
    required this.bodyMedium,
    required this.bodySemiBold,
    required this.formInput,
  });

  factory AppTextTheme.light() {
    return AppTextTheme(
      bodyRegular: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodyBold: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodySemiBold: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodySmallRegular: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodySmallBold: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodySmallMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodySmallSemiBold: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodyLargeRegular: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodyLargeBold: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodyLargeMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      bodyLargeSemiBold: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      formLabel: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      pageHeader: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 1.2,
        color: CustomTheme.textColor,
      ),
      button: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.25,
        color: Colors.white,
      ),
      navBar: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.2,
        color: CustomTheme.textColor,
      ),
      appTitle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 1.1,
        color: CustomTheme.textColor,
      ),
      formInput: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.375,
        color: CustomTheme.textColor,
      ),
    );
  }

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? bodyRegular,
    TextStyle? bodyMedium,
    TextStyle? bodySemiBold,
    TextStyle? bodyBold,
    TextStyle? bodySmallRegular,
    TextStyle? bodySmallMedium,
    TextStyle? bodySmallSemiBold,
    TextStyle? bodySmallBold,
    TextStyle? bodyLargeRegular,
    TextStyle? bodyLargeMedium,
    TextStyle? bodyLargeSemiBold,
    TextStyle? bodyLargeBold,
    TextStyle? formLabel,
    TextStyle? appTitle,
    TextStyle? pageHeader,
    TextStyle? button,
    TextStyle? navBar,
    TextStyle? formInput,
  }) {
    return AppTextTheme(
      bodyRegular: bodyRegular ?? this.bodyRegular,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySemiBold: bodySemiBold ?? this.bodySemiBold,
      bodyBold: bodyBold ?? this.bodyBold,
      formLabel: formLabel ?? this.formLabel,
      appTitle: appTitle ?? this.appTitle,
      pageHeader: pageHeader ?? this.pageHeader,
      button: button ?? this.button,
      navBar: navBar ?? this.navBar,
      bodySmallRegular: bodySmallRegular ?? this.bodySmallRegular,
      bodySmallMedium: bodySmallMedium ?? this.bodySmallMedium,
      bodySmallSemiBold: bodySmallSemiBold ?? this.bodySmallSemiBold,
      bodySmallBold: bodySmallBold ?? this.bodySmallBold,
      bodyLargeRegular: bodyLargeRegular ?? this.bodyLargeRegular,
      bodyLargeMedium: bodyLargeMedium ?? this.bodyLargeMedium,
      bodyLargeSemiBold: bodyLargeSemiBold ?? this.bodyLargeSemiBold,
      bodyLargeBold: bodyLargeBold ?? this.bodyLargeBold,
      formInput: formInput ?? this.formInput,
    );
  }

  @override
  ThemeExtension<AppTextTheme> lerp(
      covariant ThemeExtension<AppTextTheme>? other, double t) {
    return this;
  }
}
