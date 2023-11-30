import 'package:flutter/material.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final Widget? centerWidget;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? tabBackgroundColor;
  final String? title;
  final TextStyle? titleStyle;
  final bool showBottomBorder;
  final Function()? onBackPressed;
  final bool showBackButton;
  final bool centerMiddle;
  final double? leftPadding;
  final double? rightPadding;
  final double topPadding;
  final bool showShadow;
  final Color? backButtonColor;
  final IconData? backButtonIcon;
  const CustomAppBar({
    Key? key,
    this.centerWidget,
    this.leadingIcon,
    this.bottom,
    this.backgroundColor,
    this.tabBackgroundColor,
    this.title,
    this.titleStyle,
    this.actions = const [],
    this.showBottomBorder = false,
    this.onBackPressed,
    this.centerMiddle = false,
    this.showBackButton = true,
    this.leftPadding,
    this.rightPadding,
    this.topPadding = 4,
    this.showShadow = false,
    this.backButtonColor,
    this.backButtonIcon,
  }) : super(key: key);

  Widget? getLeadingIcon(BuildContext context) {
    bool canPop = Navigator.of(context).canPop();
    if (leadingIcon != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [leadingIcon!],
      );
    } else {
      if (showBackButton && canPop) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              onPressed: onBackPressed ??
                  () {
                    Navigator.of(context).maybePop();
                  },
              padding: 8,
              icon: backButtonIcon ?? NannyIcon.arrowLeft,
              iconSize: 21,
              borderColor: CustomTheme.borderColor,
              iconColor: backButtonColor ?? CustomTheme.textColor,
            ),
          ],
        );
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          if (showShadow) CustomTheme.shadow1,
        ],
        border: showBottomBorder
            ? Border(
                bottom: BorderSide(
                  width: 1,
                  color: CustomTheme.grey.shade300,
                ),
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                left: leftPadding ?? CustomTheme.horizontalPadding,
                right: rightPadding ?? 10.wp,
                top: MediaQuery.of(context).padding.top + topPadding,
              ),
              decoration: BoxDecoration(
                color: backgroundColor ?? Colors.white,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 56),
                child: NavigationToolbar(
                  leading: getLeadingIcon(context),
                  middle: title != null
                      ? Text(
                          title!,
                          style: titleStyle ?? appTextTheme.appTitle,
                        )
                      : centerWidget,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions,
                  ),
                  centerMiddle: centerMiddle,
                  middleSpacing: NavigationToolbar.kMiddleSpacing,
                ),
              ),
            ),
          ),
          if (bottom != null)
            Container(
              color: tabBackgroundColor,
              child: bottom!,
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160);
}
