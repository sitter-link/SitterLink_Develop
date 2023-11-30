import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_outline_button.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/fetch_all_profile_setup_info_cubit.dart';
import 'package:nanny_app/features/auth/cubit/setup_nanny_profile_cubit.dart';
import 'package:nanny_app/features/auth/widgets/setup_availability_section.dart';
import 'package:nanny_app/features/auth/widgets/setup_experience_section.dart';
import 'package:nanny_app/features/auth/widgets/setup_personal_info_section.dart';
import 'package:progress_stepper/progress_stepper.dart';

class SetupNannyProfileBody extends StatefulWidget {
  const SetupNannyProfileBody({super.key});

  @override
  State<SetupNannyProfileBody> createState() => _SetupNannyProfileBodyState();
}

class _SetupNannyProfileBodyState extends State<SetupNannyProfileBody> {
  final PageController _pageController = PageController();
  int currentIndex = 1;
  final GlobalKey<FormBuilderState> _personalInfoFieldsKeys =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _experienceFieldsKeys =
      GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _availabilityFieldsKeys =
      GlobalKey<FormBuilderState>();

  @override
  void initState() {
    context.read<FetchAllProfileSetupInfoCubit>().fetchInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomOutlineButton(
                title: "Skip",
                borderRadius: 100,
                horizontalPadding: 20,
                verticalPadding: 12,
                borderColor: CustomTheme.borderColor,
                textColor: CustomTheme.textColor,
                onPressed: () {
                  NavigationService.pushNamedAndRemoveUntil(
                    routeName: Routes.nannyDashboard,
                  );
                },
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocListenerWrapper<SetupNannyProfileCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: "Profile setup successfully!!",
            );
            NavigationService.pushNamedAndRemoveUntil(
              routeName: Routes.nannyDashboard,
            );
          }
        },
        child: Column(
          children: [
            Container(
              width: context.width,
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Setup profile",
                    style: appTextTheme.bodyLargeBold.copyWith(
                      fontSize: 28,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 8.hp),
                  Text(
                    "Complete profile will help parents to find you.",
                    style: appTextTheme.bodyRegular.copyWith(
                      color: CustomTheme.grey,
                      letterSpacing: 0.7,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
                vertical: 12.hp,
              ),
              child: ProgressStepper(
                stepCount: 3,
                currentStep: currentIndex,
                width: 100.w,
                color: CustomTheme.primaryColor,
                onClick: (index) {
                  setState(() {
                    currentIndex = index;
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  });
                },
                builder: (index) {
                  return Container(
                    height: 4.hp,
                    width: 30.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: index <= currentIndex
                          ? CustomTheme.primaryColor
                          : const Color(0xFFEEECFF),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value + 1;
                  });
                },
                children: [
                  SetupPersonalInfoSection(
                    pageController: _pageController,
                    personalKeysFields: _personalInfoFieldsKeys,
                  ),
                  SetupExperienceSection(
                    pageController: _pageController,
                    experienceFieldsKeys: _experienceFieldsKeys,
                  ),
                  SetupAvailabilitySection(
                    pageController: _pageController,
                    availabilityFieldKeys: _availabilityFieldsKeys,
                    experienceFieldKeys: _experienceFieldsKeys,
                    personalInfoFieldKeys: _personalInfoFieldsKeys,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
