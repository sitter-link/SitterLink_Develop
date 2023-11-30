import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/images/rounded_image.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/list_tile/custom_list_tile.dart';
import 'package:nanny_app/features/auth/enums/role.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepo = context.read<UserRepository>();
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: const CustomAppBar(
        title: "Profile",
        actions: [
          // CustomIconButton(
          //   icon: NannyIcon.userEdit,
          //   iconColor: CustomTheme.textColor,
          //   borderColor: Colors.white,
          //   padding: 9,
          //   iconSize: 23,
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
          child: Column(
            children: [
              const _ProfileInfoCard(),
              SizedBox(height: 24.hp),
              Card(
                child: Column(
                  children: [
                    CustomListTile(
                      title: "Profile Information",
                      showBorder: true,
                      suffix: Icon(
                        CupertinoIcons.right_chevron,
                        size: 20,
                        color: CustomTheme.grey,
                      ),
                      onPressed: () {
                        if (userRepo.user.value?.role == Role.Nanny) {
                          NavigationService.pushNamed(
                            routeName: Routes.nannyProfileInformation,
                          );
                        } else {
                          NavigationService.pushNamed(
                            routeName: Routes.customerProfileInformation,
                          );
                        }
                      },
                    ),
                      CustomListTile(
                        title: "Change Phone Number",
                        suffix: Icon(
                          CupertinoIcons.right_chevron,
                          size: 20,
                          color: CustomTheme.grey,
                        ),
                        onPressed: () {
                          NavigationService.pushNamed(
                            routeName: Routes.changePhoneNumber,
                          );
                        },
                      ),
                    if (userRepo.user.value?.role == Role.Nanny)
                      CustomListTile(
                        title: "My Ratings & Feedbacks",
                        suffix: Icon(
                          CupertinoIcons.right_chevron,
                          size: 20,
                          color: CustomTheme.grey,
                        ),
                        onPressed: () {
                          NavigationService.pushNamed(
                            routeName: Routes.ratingandfeedbackPage,
                          );
                        },
                      ),
                  ],
                ),
              ),
              // SizedBox(height: 24.hp),
              // Card(
              //   child: Column(
              //     children: [
              //       CustomListTile(
              //         title: "Terms And Conditions",
              //         suffix: Icon(
              //           CupertinoIcons.right_chevron,
              //           size: 22,
              //           color: CustomTheme.grey,
              //         ),
              //         showBorder: true,
              //       ),
              //       CustomListTile(
              //         title: "FAQs",
              //         showBorder: true,
              //         suffix: Icon(
              //           CupertinoIcons.right_chevron,
              //           size: 22,
              //           color: CustomTheme.grey,
              //         ),
              //       ),
              //       CustomListTile(
              //         title: "Give us ratings",
              //         suffix: Icon(
              //           CupertinoIcons.right_chevron,
              //           size: 22,
              //           color: CustomTheme.grey,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(height: 24.hp),
              CustomRoundedButtom(
                color: Colors.white,
                textColor: CustomTheme.red,
                title: "LOG OUT",
                onPressed: () {
                  RepositoryProvider.of<UserRepository>(context).logout();
                  SnackBarUtils.showErrorMessage(
                    context: context,
                    message: "Logged Out Successfully",
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.roleSelectionView,
                    (route) => false,
                  );
                },
                iconSize: 20,
                prefixIcon: (NannyIcon.logout),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  const _ProfileInfoCard();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: const EdgeInsets.all(CustomTheme.cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ValueListenableBuilder<User?>(
        valueListenable: context.read<UserRepository>().user,
        builder: (context, user, _) {
          return Row(
            children: [
              CustomRoundedImage(
                width: 64.wp,
                height: 64.wp,
                url: user?.avatar??"",
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user?.fullName ?? "Guest",
                    style: appTextTheme.bodyLargeBold.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.phone ?? "",
                    style: appTextTheme.bodySmallRegular.copyWith(
                      color: CustomTheme.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
