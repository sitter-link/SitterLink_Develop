import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/constants/locale.dart';

class LocalizationWrapper extends StatelessWidget {
  final Widget child;
  const LocalizationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: SupportedLocale.locales,
      path: 'assets/translations',
      fallbackLocale: SupportedLocale.en,
      child: child,
    );
  }
}
