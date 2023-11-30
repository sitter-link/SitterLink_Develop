import 'package:flutter/material.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/features/notification/model/notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final Widget? bottomSection;
  const NotificationCard({
    super.key,
    this.bottomSection,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomTheme.pageTopPadding / 2),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        child: CustomIconButton(
                      onPressed: () {
                        // showRequestDialog(
                        //   context: context,
                        //   description:
                        //       "You have accepted request from Jono Dry for 02 NOV to 04 NOV.",
                        //   title: "Request Sent !!",
                        // );
                      },
                      icon: NannyIcon.notification,
                      iconColor: CustomTheme.grey.shade400,
                      borderColor: CustomTheme.backgroundColor,
                      padding: 9,
                      iconSize: 23,
                      backgroundColor: CustomTheme.backgroundColor,
                    )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 16,
                              color: CustomTheme.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 130),
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: notification.description,
                                style: appTextTheme.bodySmallRegular
                                    .copyWith(color: CustomTheme.grey),
                                // children: [
                                //   TextSpan(
                                //       text: "2500+",
                                //       style: appTextTheme.bodySmallBold
                                //           .copyWith(
                                //               color: CustomTheme.primaryColor)),
                                //   TextSpan(
                                //       text: " available nannies.",
                                //       style: appTextTheme.bodySmallRegular
                                //           .copyWith(color: CustomTheme.grey))
                                // ],
                              ),
                            ),
                          ),
                          if (bottomSection != null)
                            Container(
                                padding: EdgeInsets.only(top: 8.hp),
                                child: bottomSection!),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
