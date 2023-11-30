import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/enum/booking_status.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/images/rounded_image.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/widgets/ads_container.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/cards/user_card.dart';
import 'package:nanny_app/core/widgets/dialogs/request_dialog.dart';
import 'package:nanny_app/core/widgets/placeholder/no_data_available.dart';
import 'package:nanny_app/core/widgets/placeholder/user_card_placeholder.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/update_booking_status_cubit.dart';
import 'package:nanny_app/features/book_nanny/model/update_booking_status_param.dart';
import 'package:nanny_app/features/customer_history/model/booking.dart';
import 'package:nanny_app/features/nanny_home/cubit/fetch_pending_booking_list_cubit.dart';
import 'package:nanny_app/features/nanny_home/widgets/request_summary_bottomsheet.dart';

class NannyHomeBody extends StatefulWidget {
  const NannyHomeBody({super.key});

  @override
  State<NannyHomeBody> createState() => _NannyHomeBodyState();
}

class _NannyHomeBodyState extends State<NannyHomeBody> {
  User? user;
  late UserRepository userRepo;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    userRepo = context.read<UserRepository>();
    user = userRepo.user.value;

    userRepo.user.addListener(updateUser);
  }

  updateUser() {
    if (mounted) {
      setState(() {
        user = userRepo.user.value;
      });
    }
  }

  @override
  void dispose() {
    userRepo.user.removeListener(updateUser);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: CustomAppBar(
        title: "Hi, ${user?.fullName ?? "Guest"}",
        leadingIcon: InkWell(
          onTap: () {},
          child: CustomRoundedImage(
            url: user?.avatar ?? "",
            height: 38.wp,
            width: 38.wp,
          ),
        ),
        actions: [
          CustomIconButton(
            icon: NannyIcon.notification,
            iconColor: CustomTheme.grey.shade400,
            borderColor: CustomTheme.grey.shade300,
            padding: 9,
            iconSize: 23,
            onPressed: () {
              NavigationService.pushNamed(routeName: Routes.nannyNotification);
            },
          )
        ],
      ),
      body: BlocListenerWrapper<UpdateBookingStatusCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState<UpdateBookingStatusParam>) {
            if (state.data.status == BookingStatus.accepted) {
              String formatedDate = switch (state.data.bookingDates.length) {
                1 => Jiffy.parseFromDateTime(state.data.bookingDates.first.date)
                    .format(pattern: "dd MMM, yyyy")
                    .toUpperCase(),
                >= 2 =>
                  "${Jiffy.parseFromDateTime(state.data.bookingDates.first.date).format(pattern: "dd MMM, yyyy").toUpperCase()} to ${Jiffy.parseFromDateTime(state.data.bookingDates.last.date).format(pattern: "dd MMM, yyyy").toUpperCase()}"
                      .toUpperCase(),
                _ => "",
              };
              showRequestDialog(
                context: context,
                title: "Request Accepted!!",
                description:
                    "You have accepted request from ${state.data.name} for $formatedDate",
              );
            } else {
              SnackBarUtils.showSuccessMessage(
                context: context,
                message:
                    "Booking ${state.data.status.name.capitalize()} Successfully",
              );
            }
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverSizedBox(height: 16.hp),
            const SliverToBoxAdapter(child: AdsWidget()),
            SliverSizedBox(height: 16.hp),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomTheme.horizontalPadding),
                child: BlocSelector<FetchPendingBookingListCubit, CommonState,
                    String?>(
                  selector: (state) {
                    if (state is CommonSuccessState<List<Booking>>) {
                      return state.data.length.toString();
                    } else {
                      return null;
                    }
                  },
                  builder: (context, state) {
                    if (state != null) {
                      return Text(
                        "$state Pending Request",
                        style: appTextTheme.bodyMedium,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                CustomTheme.horizontalPadding,
                16,
                CustomTheme.horizontalPadding,
                20.hp,
              ),
              sliver: BlocBuilderWrapper<FetchPendingBookingListCubit>(
                useSliver: true,
                loadingWidget: const SliverUserCardPlaceHolderList(),
                noDataWidget: const SliverToBoxAdapter(
                  child: NoDataAvailable(
                    message: "No Pending Request Available",
                    image: Assets.pending,
                  ),
                ),
                builder: (context, state) {
                  if (state is CommonSuccessState<List<Booking>>) {
                    return SliverList.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return UserCard(
                          name: state.data[index].user.fullName,
                          amountPerHrs:
                              state.data[index].nanny.perHrsRate.toString(),
                          noOfExperience: 2,
                          chipItems: [
                            state.data[index].commitmentType.name.capitalize()
                          ],
                          pinkChipItems: state.data[index].careNeeded
                              .map((e) => e.value.capitalize())
                              .toList(),
                          city: state.data[index].nanny.city,
                          country: state.data[index].nanny.country,
                          image: state.data[index].user.avatar,
                          bookingDates: state.data[index].bookingDate
                              .map((e) => e.date)
                              .toList(),
                          favoriteSection: const SizedBox.shrink(),
                          bottomSection: state.data[index].status ==
                                  BookingStatus.pending
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: CustomRoundedButtom(
                                        title: "ACCEPT REQUESTS",
                                        prefixIcon: Icons.check_circle_outline,
                                        onPressed: () {
                                          showRequestSummeryBottomSheet(
                                            context: context,
                                            booking: state.data[index],
                                            onAcceptPressed: () {
                                              BlocProvider.of<
                                                          UpdateBookingStatusCubit>(
                                                      NavigationService.context)
                                                  .updateBooking(
                                                UpdateBookingStatusParam(
                                                  bookingId:
                                                      state.data[index].id,
                                                  name: state.data[index].user
                                                      .fullName,
                                                  bookingDates: state
                                                      .data[index].bookingDate,
                                                  status:
                                                      BookingStatus.accepted,
                                                ),
                                              );
                                            },
                                            onRejectPressed: () {
                                              BlocProvider.of<
                                                          UpdateBookingStatusCubit>(
                                                      NavigationService.context)
                                                  .updateBooking(
                                                UpdateBookingStatusParam(
                                                  bookingId:
                                                      state.data[index].id,
                                                  name: state.data[index].user
                                                      .fullName,
                                                  bookingDates: state
                                                      .data[index].bookingDate,
                                                  status:
                                                      BookingStatus.rejected,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        iconSize: 18,
                                        fontSize: 15,
                                        color: CustomTheme.primaryColor,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    CustomIconButton(
                                      icon: NannyIcon.closeCircle,
                                      borderRadius: 8,
                                      padding: 13.5,
                                      iconSize: 22,
                                      onPressed: () {
                                        BlocProvider.of<
                                                    UpdateBookingStatusCubit>(
                                                NavigationService.context)
                                            .updateBooking(
                                          UpdateBookingStatusParam(
                                            bookingId: state.data[index].id,
                                            name:
                                                state.data[index].user.fullName,
                                            bookingDates:
                                                state.data[index].bookingDate,
                                            status: BookingStatus.rejected,
                                          ),
                                        );
                                      },
                                      iconColor: CustomTheme.red,
                                      backgroundColor: CustomTheme.red.shade100,
                                    )
                                  ],
                                )
                              : const SizedBox.shrink(),
                        );
                      },
                    );
                  } else {
                    return const SliverToBoxAdapter();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RequestDetailCard extends StatelessWidget {
  final String title;
  final Widget widget;
  const RequestDetailCard({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: appTextTheme.bodyLargeBold.copyWith(fontSize: 20),
        ),
        SizedBox(
          height: 12.hp,
        ),
        Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CustomTheme.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: widget)
      ],
    );
  }
}
