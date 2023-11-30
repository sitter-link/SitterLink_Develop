import 'package:flutter/material.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/widgets/role_card.dart';

class RoleSelectionBody extends StatefulWidget {
  const RoleSelectionBody({super.key});

  @override
  State<RoleSelectionBody> createState() => _RoleSelectionBodyState();
}

class _RoleSelectionBodyState extends State<RoleSelectionBody> {
  Role selectedRole = Role.Parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.hp, bottom: 48.hp),
            padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding),
            child: const Text(
              "I am,",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoleCard(
                  image: Assets.parent,
                  title: "Parent",
                  isSelected: selectedRole == Role.Parent,
                  onPressed: () {
                    setState(() {
                      selectedRole = Role.Parent;
                    });
                  },
                ),
                RoleCard(
                  image: Assets.nanny,
                  title: "Sitter",
                  isSelected: selectedRole == Role.Nanny,
                  onPressed: () {
                    setState(() {
                      selectedRole = Role.Nanny;
                    });
                  },
                )
              ],
            ),
          ),
          const Spacer(),
          CustomRoundedButtom(
            horizontalMargin: CustomTheme.horizontalPadding,
            title: "CONTINUE",
            onPressed: () {
              NavigationService.pushNamed(
                routeName: Routes.login,
                args: selectedRole,
              );
            },
          ),
          SizedBox(
            height: context.bottomViewPadding + 20.hp,
          )
        ],
      ),
    );
  }
}
