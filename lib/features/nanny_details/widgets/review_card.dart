import 'package:flutter/material.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/images/rounded_image.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class ReviewCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String avatar;
  final int rating;
  const ReviewCard({
    Key? key,
    required this.avatar,
    required this.title,
    required this.description,
    required this.date,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRoundedImage(
            width: 54.wp,
            height: 54.wp,
            url: avatar,
          ),
          SizedBox(width: 12.hp),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: appTextTheme.bodyBold,
                    ),
                    const Spacer(),
                    Text(
                      date,
                      style: appTextTheme.bodySmallRegular
                          .copyWith(color: CustomTheme.grey),
                    ),
                  ],
                ),
                SizedBox(height: 4..hp),
                Row(
                  children: List.generate(
                    rating,
                    (index) => Icon(
                      NannyIcon.star,
                      size: 16,
                      color: CustomTheme.yellow,
                    ),
                  ),
                ),
                SizedBox(height: 10..hp),
                Text(
                  description,
                  style: appTextTheme.bodyRegular.copyWith(
                    height: 1.4,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
