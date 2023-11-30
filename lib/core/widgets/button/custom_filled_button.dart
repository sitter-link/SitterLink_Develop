import 'package:flutter/material.dart';
import 'package:nanny_app/core/animations/tap_effect.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/cards/shadow_container.dart';

class CustomFilledButton extends StatelessWidget {
  final IconData? prefixIcon;
  final Color? prefixColor;
  final IconData? suffixIcon;
  final Color? suffixColor;
  final String title;
  final TextStyle? titleStyle;
  final Color? fillColor;
  final VoidCallback? onPressed;
  final EdgeInsets? containerMargin;
  final EdgeInsets? containerPadding;
  final bool showShadow;
  final double iconSize;
  final bool disabled;

  final int? flex;
  const CustomFilledButton({
    super.key,
    required this.title,
    this.titleStyle,
    this.fillColor,
    this.prefixIcon,
    this.prefixColor,
    this.suffixIcon,
    this.suffixColor,
    this.onPressed,
    this.containerMargin,
    this.containerPadding,
    this.flex = 1,
    this.showShadow = true,
    this.iconSize = 24,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: TapEffect(
        scaleDown: 0.95,
        child: ShadowContainer(
          cardColor: disabled ? CustomTheme.grey.shade300 : fillColor,
          containerPadding: EdgeInsets.zero,
          showShadow: showShadow,
          containerMargin: containerMargin ?? const EdgeInsets.all(0),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: containerPadding ?? const EdgeInsets.all(14),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null)
                    Container(
                      padding: EdgeInsets.only(right: 10.wp),
                      child: Icon(
                        prefixIcon,
                        size: iconSize,
                        color:
                            disabled ? CustomTheme.grey.shade300 : prefixColor,
                      ),
                    ),
                  Expanded(
                    flex: flex!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: (titleStyle ??
                                  TextStyle(
                                    color: CustomTheme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ))
                              .copyWith(
                                  color: disabled
                                      ? CustomTheme.grey.shade300
                                      : null),
                        ),
                      ],
                    ),
                  ),
                  if (suffixIcon != null)
                    Container(
                      padding: EdgeInsets.only(left: 10.wp),
                      child: Icon(
                        suffixIcon,
                        size: iconSize,
                        color:
                            disabled ? CustomTheme.grey.shade300 : suffixColor,
                      ),
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
