import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class CustomChip extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final String label;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? labelColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final EdgeInsets? margin;
  final BoxBorder? border;
  final Alignment? alignment;

  const CustomChip({
    Key? key,
    this.backgroundColor,
    this.child,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w400,
    this.horizontalPadding = 8,
    this.label = "",
    this.verticalPadding = 4,
    this.labelColor,
    this.borderRadius = 4,
    this.margin,
    this.border,
    this.alignment = Alignment.center,
  })  : assert(child != null || label.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ?? theme.primaryColor,
        border: border,
      ),
      child: child ??
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: labelColor ?? CustomTheme.textColor,
              fontWeight: fontWeight,
            ),
          ),
    );
  }
}
