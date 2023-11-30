import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/enum/booking_status.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/cards/user_card.dart';
import 'package:nanny_app/core/widgets/dialogs/request_dialog.dart';
import 'package:nanny_app/core/widgets/placeholder/user_card_placeholder.dart';
import 'package:nanny_app/core/widgets/text_fields/search_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/update_booking_status_cubit.dart';
import 'package:nanny_app/features/book_nanny/model/update_booking_status_param.dart';
import 'package:nanny_app/features/customer_history/cubit/fetch_customer_booking_history_cubit.dart';
import 'package:nanny_app/features/customer_history/model/booking.dart';
import 'package:nanny_app/features/nanny_history/cubit/ask_for_payment_request_cubit.dart';
import 'package:nanny_app/features/nanny_home/widgets/request_summary_bottomsheet.dart';

class NannyHistoryBody extends StatefulWidget {
  const NannyHistoryBody({super.key});

  @override
  State<NannyHistoryBody> createState() => _NannyHistoryBodyState();
}

class _NannyHistoryBodyState extends State<NannyHistoryBody> {
  final TextEditingController _searchController = TextEditingController();
  String lastParam = "";

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "History",
      ),
      body: BlocListenerWrapper<AskForPaymentRequestCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: "Payment Requested Successfully!!",
            );
          }
        },
        child: BlocListenerWrapper<UpdateBookingStatusCubit>(
          listener: (context, state) {
            if (state is CommonSuccessState<UpdateBookingStatusParam>) {
              if (state.data.status == BookingStatus.accepted) {
                String formatedDate = switch (state.data.bookingDates.length) {
                  1 =>
                    Jiffy.parseFromDateTime(state.data.bookingDates.first.date)
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.horizontalPadding,
                  vertical: 8.hp,
                ),
                child: SearchtextField(
                  controller: _searchController,
                  hintText: "Search with name ...",
                  isFilled: true,
                  onSearchPressed: () {
                    if (lastParam != _searchController.text) {
                      lastParam = _searchController.text;
                      context
                          .read<FetchCustomerBookingHistoryCubit>()
                          .fetchBookings(fullName: _searchController.text);
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ),
              Expanded(
                child: BlocBuilderWrapper<FetchCustomerBookingHistoryCubit>(
                  loadingWidget: const SingleChildScrollView(
                    child: UserCardPlaceHolderList(),
                  ),
                  builder: (context, state) {
                    if (state is CommonSuccessState<List<Booking>>) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: CustomTheme.horizontalPadding),
                        itemBuilder: (context, index) {
                          return UserCard(
                            name: state.data[index].user.fullName,
                            noOfExperience: 0,
                            age: 0,
                            amountPerHrs: "",
                            totalAmount:
                                state.data[index].totalAmount.toString(),
                            chipItems: state.data[index].nanny.commitmentType
                                .map((e) => e.name.capitalize())
                                .toList(),
                            pinkChipItems: state.data[index].careNeeded
                                .map((e) => e.value.capitalize())
                                .toList(),
                            country: state.data[index].nanny.country,
                            city: state.data[index].nanny.city,
                            image: state.data[index].user.avatar,
                            bookingDates: state.data[index].bookingDate
                                .map((e) => e.date)
                                .toList(),
                            favoriteSection: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                color: state.data[index].hasPaymentDone
                                    ? const Color(0xFFFFFCF2)
                                    : const Color(0xFFFFEBEF),
                              ),
                              child: Text(
                                state.data[index].hasPaymentDone
                                    ? "PAID"
                                    : "UNPAID",
                                style: appTextTheme.bodySemiBold.copyWith(
                                  color: state.data[index].hasPaymentDone
                                      ? const Color(0xFFFFD233)
                                      : const Color(0xFFFF3358),
                                ),
                              ),
                            ),
                            bottomSection: switch (state.data[index].status) {
                              BookingStatus.pending => Row(
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
                                ),
                              BookingStatus.accepted =>
                                state.data[index].hasPaymentDone
                                    ? null
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: CustomRoundedButtom(
                                              title: "ASK FOR PAYMENT",
                                              prefixIcon: NannyIcon.receiptItem,
                                              onPressed: () {
                                                context
                                                    .read<
                                                        AskForPaymentRequestCubit>()
                                                    .askPayment(
                                                        state.data[index].id);
                                              },
                                              iconSize: 18,
                                              fontSize: 15,
                                              color: CustomTheme.primaryColor,
                                              textColor: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                              _ => null,
                            },
                          );
                        },
                        itemCount: state.data.length,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
