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
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/fetch_days_timeslot_cubit.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/nanny_details/cubits/fetch_nanny_details_cubit.dart';
import 'package:nanny_app/features/profile/cubit/update_avatar_cubit.dart';
import 'package:nanny_app/features/profile/widgets/nanny_profile_information_professional_tabview.dart';
import 'package:nanny_app/features/profile/widgets/nanny_profile_information_schedule_tabview.dart';
import 'package:nanny_app/features/profile/widgets/nanny_profileinformation_personal_tabview.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NannyProfileInformationBody extends StatefulWidget {
  const NannyProfileInformationBody({super.key});

  @override
  State<NannyProfileInformationBody> createState() =>
      _NannyProfileInformationBodyState();
}

class _NannyProfileInformationBodyState
    extends State<NannyProfileInformationBody> {
  @override
  void initState() {
    super.initState();
    context.read<FetchDaysCubit>().fetchDaysTimeslots();
  }

  @override
  Widget build(BuildContext context) {
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
          child: DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ValueListenableBuilder<User?>(
                              valueListenable:
                                  context.read<UserRepository>().user,
                              builder: (context, user, _) {
                                return CustomRoundedImage(
                                  width: 150.wp,
                                  height: 150.wp,
                                  url: user?.avatar ?? "",
                                );
                              },
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
                                          final res = await ImagePickerUtils
                                              .getGallery();
                                          NavigationService.pop();
                                          if (res != null) {
                                            context
                                                .read<UpdateAvatarCubit>()
                                                .updateAvatar(res);
                                          }
                                        },
                                        onCameraPressed: () async {
                                          final res = await ImagePickerUtils
                                              .getCamera();
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
                      ],
                    ),
                  ),
                  const SliverPinnedHeader(
                    child: _ProfileInformationTabBar(),
                  )
                ];
              },
              body: BlocBuilderWrapper<FetchNannyDetailsCubit>(
                builder: (context, state) {
                  if (state is CommonSuccessState<Nanny>) {
                    return TabBarView(
                      children: [
                        NannyProfilePersonalInformationTabBarView(
                          nanny: state.data,
                        ),
                        NannyPersonalInformationProfessionalTabBarView(
                          nanny: state.data,
                        ),
                        NannyPersonalInformationScheduleTabBarView(
                          nanny: state.data,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ));
  }
}

class _ProfileInformationTabBar extends StatelessWidget {
  const _ProfileInformationTabBar();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomTheme.horizontalPadding,
        vertical: 12,
      ),
      color: CustomTheme.backgroundColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: CustomTheme.backgroundColor,
        ),
        child: TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          tabs: const [
            Tab(
              text: 'Personal',
            ),
            Tab(
              text: "Professional",
            ),
            Tab(
              text: "Schedule",
            )
          ],
          labelPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 4),
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(27),
          ),
          indicatorPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          indicatorColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return states.contains(MaterialState.focused)
                ? null
                : Colors.transparent;
          }),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelStyle: appTextTheme.bodyMedium,
          labelColor: CustomTheme.textColor,
          splashBorderRadius: BorderRadius.circular(0),
          unselectedLabelColor: CustomTheme.grey,
        ),
      ),
    );
  }
}
