import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class DottedButton extends StatelessWidget {
  final String title;
  final String svgImagePath;
  final String imagePath;
  final IconData? iconData;
  final Function onPressed;
  final double borderRadius;
  final bool isIconCentered;
  final Color? textColor;
  final Color? iconColor;
  final FontWeight fontWeight;

  const DottedButton({
    super.key,
    required this.title,
    this.svgImagePath = "",
    this.iconData,
    required this.onPressed,
    this.imagePath = "",
    this.borderRadius = 24,
    this.isIconCentered = false,
    this.textColor,
    this.iconColor,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () => onPressed(),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: CustomTheme.borderColor,
          dashPattern: const [8, 5],
          radius: Radius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            constraints: const BoxConstraints(minHeight: 45),
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            child: Row(
              mainAxisAlignment: isIconCentered
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              textBaseline: TextBaseline.ideographic,
              children: [
                if (svgImagePath.isNotEmpty)
                  SvgPicture.asset(
                    svgImagePath,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      iconColor ?? CustomTheme.primaryColor,
                      BlendMode.srcATop,
                    ),
                  ),
                if (imagePath.isNotEmpty)
                  Image.asset(
                    imagePath,
                    height: 20,
                    width: 20,
                    color: iconColor ?? CustomTheme.primaryColor,
                  ),
                if (iconData != null)
                  Icon(
                    iconData,
                    size: 20,
                    color: iconColor ?? CustomTheme.primaryColor,
                  ),
                if (imagePath.isNotEmpty ||
                    svgImagePath.isNotEmpty ||
                    iconData != null)
                  const SizedBox(width: 10),
                Flexible(
                  fit: FlexFit.tight,
                  flex: isIconCentered ? 0 : 1,
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: fontWeight,
                      color: textColor ?? CustomTheme.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
