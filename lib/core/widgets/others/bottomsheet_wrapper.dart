import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const BottomSheetWrapper({
    super.key,
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        color: backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 24),
            height: 4,
            width: 55,
            decoration: BoxDecoration(
              color: CustomTheme.borderColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child,
          Container(
            height:
                context.bottomViewPadding > 0 ? context.bottomViewPadding : 20,
          )
        ],
      ),
    );
  }
}
