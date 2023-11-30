import 'package:flutter/material.dart';
import 'package:nanny_app/core/images/custom_network_image.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class CustomListTile extends StatelessWidget {
  final String? image;
  final double? imageHeight;
  final double? imageWidht;
  final Widget? suffix;
  final String title;
  final TextStyle? titleStyle;
  final String? descrption;
  final TextStyle? descriptionStyle;
  final VoidCallback? onPressed;
  final EdgeInsets? cardPadding;
  final EdgeInsets? cardMargin;
  final double borderRadius;
  final Widget? prefix;
  final VoidCallback? onLongPressed;
  final Widget? extraChild;
  final bool showBorder;

  const CustomListTile({
    super.key,
    this.extraChild,
    required this.title,
    this.titleStyle,
    this.descrption,
    this.descriptionStyle,
    this.suffix,
    this.image,
    this.imageHeight,
    this.imageWidht,
    this.onPressed,
    this.prefix,
    this.cardPadding,
    this.cardMargin,
    this.borderRadius = 4,
    this.onLongPressed,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          margin: cardMargin,
          padding: cardPadding ?? const EdgeInsets.all(CustomTheme.cardPadding),
          decoration: BoxDecoration(
            border: Border(
              bottom: showBorder
                  ? BorderSide(
                      color: CustomTheme.backgroundColor,
                      width: 1,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Row(
            crossAxisAlignment: suffix != null
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              if (prefix != null)
                Container(
                  padding: EdgeInsets.only(right: 16.wp),
                  child: prefix!,
                ),
              if (image != null)
                Container(
                  padding: EdgeInsets.only(right: 16.wp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CustomCachedNetworkImage(
                      url: image!,
                      height: imageHeight ?? 36.hp,
                      width: imageWidht ?? 36.wp,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: title,
                        style: titleStyle ?? appTextTheme.bodyRegular,
                      ),
                    ),
                    if (descrption?.isNotEmpty ?? false)
                      Container(
                        padding: EdgeInsets.only(top: 4.hp),
                        child: Text(
                          descrption!,
                          style: descriptionStyle ??
                              appTextTheme.bodySmallRegular.copyWith(
                                color: CustomTheme.grey,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
              if (suffix != null)
                Container(
                  padding: EdgeInsets.only(left: 16.wp),
                  child: suffix,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
