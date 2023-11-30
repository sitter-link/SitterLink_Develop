import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final String title;
  final String subtitle;
  final double? titleFontSize;
  final Function()? onPressed;
  final double horizontalPadding;
  final Widget? value;
  const SectionWrapper({
    super.key,
    this.titleFontSize,
    this.onPressed,
    required this.title,
    this.value,
    required this.child,
    this.subtitle = "",
    this.horizontalPadding = CustomTheme.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: appTextTheme.appTitle.copyWith(
                    fontSize: titleFontSize ?? 20,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    letterSpacing: 1.1,
                  ),
                ),
                const Spacer(),
                if (value != null) value!
              ],
            ),
            if (subtitle.isNotEmpty)
              Container(
                padding: const EdgeInsets.only(top: 4, bottom: 16),
                child: Text(
                  subtitle,
                  style: appTextTheme.bodySmallRegular.copyWith(
                    color: CustomTheme.grey,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
            if (subtitle.isEmpty) const SizedBox(height: 16),
            child
          ],
        ),
      ),
    );
  }
}
