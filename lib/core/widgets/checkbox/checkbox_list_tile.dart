import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class CustomCheckboxListTile extends StatelessWidget {
  const CustomCheckboxListTile({
    super.key,
    required this.isChecked,
    required this.onChanged,
    required this.onPressed,
    required this.text,
    required this.markText,
  });
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final VoidCallback onPressed;
  final String text;
  final String markText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (val) => onChanged(val!),
            side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(
                width: 2.0,
                color: isChecked
                    ? CustomTheme.primaryColor
                    : CustomTheme.grey.shade300,
              ),
            ),
            activeColor: CustomTheme.primaryColor,
            hoverColor: CustomTheme.primaryColor,
          ),
          RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(
                fontSize: 14,
                color: CustomTheme.grey.shade400,
              ),
              children: [
                TextSpan(
                  text: markText,
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomTheme.primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onPressed,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
