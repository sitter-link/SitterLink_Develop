import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.hp),
      child: Row(
        children: [
          CustomIconButton(
            icon: Icons.circle,
            iconColor: CustomTheme.blue,
            iconSize: 10,
            backgroundColor: CustomTheme.tableHead,
            padding: 4,
          ),
          SizedBox(
            width: 12.wp,
          ),
          Text(
            text,
            style: appTextTheme.bodyRegular,
          )
        ],
      ),
    );
  }
}
