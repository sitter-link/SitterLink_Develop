import 'package:flutter/material.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/dotted_button.dart';


class ImagePickerBottomSheet extends StatelessWidget {
  final Function onGalleryPressed;
  final Function? onCameraPressed;
  final bool? showCameraOption;

  const ImagePickerBottomSheet({
    super.key,
    this.onCameraPressed,
    required this.onGalleryPressed,
    this.showCameraOption = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24, bottom: 24),
            height: 4,
            width: 55,
            decoration: BoxDecoration(
              color: CustomTheme.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Text(
            "Upload a Photo",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 32.hp),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: DottedButton(
                    title: "Select From Gallery",
                    svgImagePath: SvgAssets.gallery,
                    onPressed: () => onGalleryPressed(),
                  ),
                ),
                if (showCameraOption!) const SizedBox(width: 20),
                if (showCameraOption!)
                  Expanded(
                    child: DottedButton(
                      title: "Take a Picture",
                      svgImagePath: SvgAssets.camera,
                      onPressed: () => onCameraPressed!(),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
