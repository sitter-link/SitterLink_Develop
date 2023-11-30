import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class CustomRoundedButtom extends StatefulWidget {
  const CustomRoundedButtom({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.padding,
    this.color,
    this.borderColor,
    this.horizontalPadding = CustomTheme.borderRadius,
    this.verticalPadding = 16,
    this.fontSize = 14,
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.horizontalMargin = 0,
    this.iconSize = 18,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);
  final String title;
  final Function()? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;
  final double horizontalMargin;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double? iconSize;

  @override
  CustomRoundedButtomState createState() => CustomRoundedButtomState();
}

class CustomRoundedButtomState extends State<CustomRoundedButtom> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
      child: Material(
        color: widget.isDisabled
            ? CustomTheme.grey.shade300
            : (widget.color ?? theme.primaryColor),
        borderRadius: BorderRadius.circular(CustomTheme.borderRadius),
        child: InkWell(
          onTap: widget.isDisabled ? null : widget.onPressed,
          borderRadius: BorderRadius.circular(CustomTheme.borderRadius),
          child: Container(
            padding: widget.padding ??
                EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                  horizontal: widget.horizontalPadding,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CustomTheme.borderRadius),
              border: widget.isDisabled
                  ? null
                  : Border.all(
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          : widget.color ?? theme.primaryColor,
                    ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.prefixIcon != null)
                    Container(
                      padding: EdgeInsets.only(right: 8.wp),
                      child: Icon(
                        widget.prefixIcon,
                        color: widget.textColor,
                        size: widget.iconSize,
                      ),
                    ),
                  Text(
                    widget.title,
                    style: theme.textTheme.displaySmall!.copyWith(
                      fontWeight: widget.fontWeight,
                      color: widget.isDisabled
                          ? CustomTheme.grey.shade700
                          : widget.textColor,
                      fontSize: widget.fontSize,
                    ),
                  ),
                  if (widget.suffixIcon != null)
                    Container(
                      padding: EdgeInsets.only(left: 8.wp),
                      child: Icon(
                        widget.suffixIcon,
                        color: widget.textColor,
                        size: widget.iconSize,
                      ),
                    ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeOut,
                    child: widget.isLoading
                        ? Container(
                            height: 14,
                            width: 14,
                            margin: const EdgeInsets.only(left: 8),
                            child: CircularProgressIndicator(
                              color: widget.textColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
