import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';

void showRequestDialog(
    {required BuildContext context,
    required String title,
    required String description,
    Function()? onPressed,
    String? bottomText}) {
  showDialog(
    context: context,
    builder: (context) {
      return _RequestDialog(
        title: title,
        description: description,
        bottomText: bottomText,
        onpressed: onPressed,
      );
    },
  );
}

class _RequestDialog extends StatelessWidget {
  final String title;
  final String description;
  final String? bottomText;
  final Function()? onpressed;

  const _RequestDialog(
      {required this.title,
      required this.description,
      this.bottomText,
      this.onpressed});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding,
              vertical: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(140),
                  child: Image.asset(
                    Assets.paymentSuccessfull,
                    fit: BoxFit.cover,
                    width: 160.wp,
                    height: 160.wp,
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  child: Text(
                    title,
                    style: appTextTheme.bodyLargeSemiBold.copyWith(
                      fontSize: 20,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: appTextTheme.bodyRegular.copyWith(
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomRoundedButtom(
                  title: bottomText ?? "DONE",
                  onPressed: onpressed ??
                      () {
                        NavigationService.popUntilFirstPage();
                      },
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: CustomIconButton(
              icon: CupertinoIcons.clear,
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconColor: CustomTheme.textColor,
              borderColor: CustomTheme.backgroundColor,
              padding: 9,
              iconSize: 20,
              backgroundColor: CustomTheme.backgroundColor,
            ),
          )
        ],
      ),
    );
  }
}
