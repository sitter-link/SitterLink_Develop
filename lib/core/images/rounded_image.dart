// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/images/custom_network_image.dart';

class CustomRoundedImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final Widget? customPlaceHolder;
  final String fallBackImage;
  final VoidCallback? onPressed;
  const CustomRoundedImage({
    Key? key,
    required this.url,
    required this.height,
    required this.width,
    this.customPlaceHolder,
    this.fallBackImage = Assets.fallbackImage,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(height > width ? height : width),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(height > width ? height : width),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(height > width ? height : width),
          child: CustomCachedNetworkImage(
            url: url,
            height: height,
            width: width,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            customPlaceHolder: customPlaceHolder,
            placeholder: fallBackImage,
          ),
        ),
      ),
    );
  }
}
