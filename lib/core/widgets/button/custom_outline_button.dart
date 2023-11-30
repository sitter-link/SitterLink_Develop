import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? borderColor;
  final Function()? onPressed;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final double borderRadius;
  final FontWeight fontWeight;

  const CustomOutlineButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.textColor,
    this.horizontalPadding = 12,
    this.verticalPadding = 14,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w700,
    this.borderRadius = CustomTheme.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? theme.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(
            title,
            style: textTheme.bodySmall!.copyWith(
              fontWeight: fontWeight,
              fontSize: fontSize,
              letterSpacing: 1,
              color: textColor ?? theme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
