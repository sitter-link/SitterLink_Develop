import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/animations/tap_effect.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class RoleCard extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final String title;
  final bool isSelected;
  const RoleCard({
    super.key,
    required this.isSelected,
    required this.image,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TapEffect(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            DottedBorder(
              borderType: BorderType.Circle,
              dashPattern: const [6, 6],
              color: isSelected ? CustomTheme.primaryColor : Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(4.wp),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(144.wp),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: 144.wp,
                    width: 144.wp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.hp),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
