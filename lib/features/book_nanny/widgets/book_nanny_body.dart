import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/model/profile_setup_info.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/dialogs/request_dialog.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/fetch_all_profile_setup_info_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/book_nanny_cubit.dart';
import 'package:nanny_app/features/book_nanny/widgets/book_step_one_section.dart';
import 'package:nanny_app/features/book_nanny/widgets/book_step_three_section.dart';
import 'package:nanny_app/features/book_nanny/widgets/book_step_two_section.dart';
import 'package:progress_stepper/progress_stepper.dart';

class BookNannyBody extends StatefulWidget {
  final int nannyId;
  const BookNannyBody({super.key, required this.nannyId});

  @override
  State<BookNannyBody> createState() => _BookNannyBodyState();
}

class _BookNannyBodyState extends State<BookNannyBody> {
  final PageController _pageController = PageController();
  final GlobalKey<FormBuilderState> _step1Key = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _step2Key = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _step3Key = GlobalKey<FormBuilderState>();
  int currentIndex = 1;

  @override
  void initState() {
    context.read<FetchAllProfileSetupInfoCubit>().fetchInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Book a Nanny",
        onBackPressed: () {
          if (currentIndex == 1) {
            NavigationService.pop();
          } else {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          }
        },
      ),
      backgroundColor: Colors.white,
      body: BlocListenerWrapper<BookNannyCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            showRequestDialog(
              context: context,
              title: "Request sent!!",
              description:
                  "Please, wait for response from nanny. Usually it takes 1-2 business hours.",
            );
          }
        },
        child: BlocBuilderWrapper<FetchAllProfileSetupInfoCubit>(
          builder: (context, state) {
            if (state is CommonSuccessState<ProfileSetupInfo>) {
              return Column(
                children: [
                  Container(
                    height: 8.hp,
                    width: 100.w,
                    color: CustomTheme.backgroundColor,
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
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value + 1;
                        });
                      },
                      children: [
                        BookStepOneSection(
                          pageController: _pageController,
                          profileSetupInfo: state.data,
                          formKey: _step1Key,
                        ),
                        BookStepTwoSection(
                          pageController: _pageController,
                          form2Key: _step2Key,
                        ),
                        BookStepThreeSection(
                          pageController: _pageController,
                          nannyId: widget.nannyId,
                          step1Key: _step1Key,
                          step2Key: _step2Key,
                          step3Key: _step3Key,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
