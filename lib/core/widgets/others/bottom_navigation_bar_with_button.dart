import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';

class BottomNavigationbarWithButton extends StatelessWidget {
  final String buttonLabel;
  final IconData? buttonPrefixIcon;
  final VoidCallback onPressed;
  final Widget? prefix;
  const BottomNavigationbarWithButton({
    super.key,
    required this.buttonLabel,
    this.buttonPrefixIcon,
    required this.onPressed,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(
            bottom: context.bottomViewPadding > 0
                ? context.bottomViewPadding + 10.hp
                : 20.hp,
            left: CustomTheme.horizontalPadding,
            right: CustomTheme.horizontalPadding,
            top: 16.hp,
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: CustomTheme.grey.shade100,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (prefix != null) prefix!,
              const Spacer(),
              SizedBox(width: 20.wp),
              CustomRoundedButtom(
                title: buttonLabel,
                prefixIcon: buttonPrefixIcon,
                horizontalPadding: buttonPrefixIcon != null ? 30.wp : 50.wp,
                onPressed: onPressed,
              )
            ],
          ),
        ),
      ],
    );
  }
}
