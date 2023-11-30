import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    super.key,
    required this.child,
    this.onPressed,
    this.containerMargin,
    this.containerPadding,
    this.cardColor,
    this.height,
    this.width,
    this.showShadow = true,
    this.alignment = Alignment.center,
  });
  final Widget child;
  final Color? cardColor;
  final VoidCallback? onPressed;
  final EdgeInsets? containerMargin;
  final EdgeInsets? containerPadding;
  final double? height;
  final double? width;
  final bool showShadow;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: containerPadding ??
            const EdgeInsets.all(CustomTheme.horizontalPadding),
        margin: containerMargin ??
            const EdgeInsets.only(
              left: CustomTheme.horizontalPadding,
              right: CustomTheme.horizontalPadding,
              bottom: CustomTheme.cardBottomMargin,
              top: CustomTheme.cardBottomMargin,
            ),
        alignment: alignment,
        decoration: BoxDecoration(
          color: cardColor ?? Colors.white,
          boxShadow: [
            if (showShadow) CustomTheme.shadow1,
          ],
          borderRadius: BorderRadius.circular(CustomTheme.borderRadius),
        ),
        child: child,
      ),
    );
  }
}
