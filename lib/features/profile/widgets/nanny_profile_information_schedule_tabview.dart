import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/model/availability.dart';
import 'package:nanny_app/core/model/day.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/others/bullet_point.dart';
import 'package:nanny_app/core/widgets/others/custom_grid.dart';
import 'package:nanny_app/core/widgets/others/section_wrapper.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/cubit/fetch_days_timeslot_cubit.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/profile/cubit/update_availability_cubit.dart';
import 'package:nanny_app/features/profile/widgets/show_working_time_bottom_sheet.dart';

class NannyPersonalInformationScheduleTabBarView extends StatelessWidget {
  final Nanny nanny;
  const NannyPersonalInformationScheduleTabBarView({
    super.key,
    required this.nanny,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListenerWrapper<UpdateAvailabilityCubit>(
      listener: (context, state) {
        if (state is CommonSuccessState) {
          SnackBarUtils.showSuccessMessage(
            context: context,
            message: "Availability Updated Successfully",
          );
        }
      },
      child: CustomScrollView(
        slivers: [
          BlocBuilderWrapper<FetchDaysCubit>(
            useSliver: true,
            builder: (context, state) {
              if (state is CommonSuccessState<List<Day>>) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: state.data.map(
                      (option) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: CustomTheme.horizontalPadding,
                              vertical: 8),
                          child: Card(
                            color: Colors.white,
                            child: SectionWrapper(
                              titleFontSize: 18,
                              onPressed: () {
                                showWorkingTimeBottomSheet(
                                  context: context,
                                  day: option,
                                  timeslots: nanny.availability
                                          .findAvailabilityViaWeekDays(
                                              option.weekday)
                                          ?.timeslots ??
                                      [],
                                  onConfirmed: (value) {
                                    context
                                        .read<UpdateAvailabilityCubit>()
                                        .update(
                                          day: option.id,
                                          shifts: value,
                                        );
                                  },
                                );
                              },
                              title: option.name,
                              value: Icon(
                                NannyIcon.edit,
                                size: 20,
                                color: CustomTheme.textColor,
                              ),
                              child: CustomGridWidget(
                                childrens: nanny.availability
                                        .findAvailabilityViaWeekDays(
                                            option.weekday)
                                        ?.timeslots
                                        .map((e) =>
                                            BulletPoint(text: e.timeslotValue))
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
          SliverSizedBox(
            height: 40.hp,
          )
        ],
      ),
    );
  }
}
