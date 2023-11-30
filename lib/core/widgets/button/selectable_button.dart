import 'package:flutter/material.dart';
import 'package:nanny_app/core/animations/tap_effect.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class SelectableCard extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback? onPressed;
  final double leftMargin;
  final double rightMargin;
  final TextStyle? titleStyle;
  final double shortTitleHozPadding;
  final double defaultHozPadding;
  final double borderRadius;
  final IconData? prefixIcon;
  final bool isDisabled;

  const SelectableCard({
    super.key,
    required this.isSelected,
    required this.title,
    this.onPressed,
    this.leftMargin = 0,
    this.rightMargin = 12,
    this.titleStyle,
    this.shortTitleHozPadding = 30,
    this.defaultHozPadding = 20,
    this.borderRadius = 8,
    this.prefixIcon,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return AbsorbPointer(
      absorbing: isDisabled,
      child: Container(
        margin: EdgeInsets.only(
          right: rightMargin,
          left: leftMargin,
          top: 4,
          bottom: 4,
        ),
        child: TapEffect(
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: title.length < 12
                    ? shortTitleHozPadding
                    : defaultHozPadding,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  width: 1,
                  color: isDisabled
                      ? CustomTheme.grey.shade300
                      : (isSelected
                          ? CustomTheme.primaryColor
                          : CustomTheme.grey),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null)
                    Container(
                      padding: EdgeInsets.only(right: 4.wp),
                      child: Icon(
                        prefixIcon,
                        color: CustomTheme.grey,
                        size: 22,
                      ),
                    ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: (titleStyle ?? appTextTheme.bodyMedium).copyWith(
                      color: isSelected
                          ? CustomTheme.primaryColor
                          : CustomTheme.grey,
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
