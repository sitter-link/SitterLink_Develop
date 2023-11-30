import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class KeyValueTile extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final bool useSpacer;
  const KeyValueTile({
    super.key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
    this.useSpacer = false,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: useSpacer ? 0 : 2,
            child: Container(
              padding: EdgeInsets.only(right: 12.wp),
              child: Text(
                title,
                style: titleStyle ?? appTextTheme.bodyRegular,
              ),
            ),
          ),
          if (useSpacer) const Spacer(),
          Expanded(
            flex: useSpacer ? 1 : 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: valueStyle ?? appTextTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
