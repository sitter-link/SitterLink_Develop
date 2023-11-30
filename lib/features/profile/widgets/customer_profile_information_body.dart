// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/images/rounded_image.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/image_picker_utils.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/image_pickers/image_picker_bottomsheet.dart';
import 'package:nanny_app/core/widgets/list_tile/custom_list_tile.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/profile/cubit/update_avatar_cubit.dart';

class CustomerProfileInformationBody extends StatefulWidget {
  const CustomerProfileInformationBody({super.key});

  @override
  State<CustomerProfileInformationBody> createState() =>
      _CustomerProfileInformationBodyState();
}

class _CustomerProfileInformationBodyState
    extends State<CustomerProfileInformationBody> {
  late UserRepository userRepository;

  @override
  void initState() {
    userRepository = context.read<UserRepository>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: const CustomAppBar(
        title: "Profile Information",
      ),
      body: BlocListenerWrapper<UpdateAvatarCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: "Profile Picture updated",
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding),
          child: ValueListenableBuilder<User?>(
              valueListenable: userRepository.user,
              builder: (context, user, _) {
                return Column(
                  children: [
                    const SizedBox(height: CustomTheme.pageTopPadding),
                    Center(
                      child: Stack(
                        children: [
                          CustomRoundedImage(
                            width: 150.wp,
                            height: 150.wp,
                            url: user?.avatar ?? "",
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CustomIconButton(
                              icon: NannyIcon.camera,
                              iconColor: CustomTheme.textColor,
                              borderColor: CustomTheme.borderColor,
                              padding: 12,
                              iconSize: 23,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return ImagePickerBottomSheet(
                                      onGalleryPressed: () async {
                                        final res =
                                            await ImagePickerUtils.getGallery();
                                        NavigationService.pop();
                                        if (res != null) {
                                          context
                                              .read<UpdateAvatarCubit>()
                                              .updateAvatar(res);
                                        }
                                      },
                                      onCameraPressed: () async {
                                        final res =
                                            await ImagePickerUtils.getCamera();
                                        NavigationService.pop();
                                        if (res != null) {
                                          context
                                              .read<UpdateAvatarCubit>()
                                              .updateAvatar(res);
                                        }
                                      },
                                      showCameraOption: true,
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40.hp),
                    Card(
                      child: Column(
                        children: [
                          CustomListTile(
                            title: "Name",
                            suffix: Text(
                              user?.fullName ?? "Guest",
                              style: appTextTheme.bodyMedium,
                            ),
                            showBorder: true,
                          ),
                          CustomListTile(
                            title: "Phone",
                            suffix: Text(
                              user?.phone ?? "",
                              style: appTextTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
