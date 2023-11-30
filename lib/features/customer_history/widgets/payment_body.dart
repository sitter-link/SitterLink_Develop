import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/dialogs/request_dialog.dart';
import 'package:nanny_app/core/widgets/list_tile/key_value_tile.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_payment_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/fetch_booking_details_cubit.dart';
import 'package:nanny_app/features/book_nanny/model/create_payment_param.dart';
import 'package:nanny_app/features/customer_history/model/booking_details.dart';
import 'package:nanny_app/features/customer_history/widgets/select_payment_method_bottomsheet.dart';

class PaymentBody extends StatelessWidget {
  final int bookingId;
  const PaymentBody({
    super.key,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: const CustomAppBar(
        title: "Payment",
      ),
      body: BlocListenerWrapper<CreatePaymentCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState<CreatePaymentParam>) {
            NavigationService.pop();
            showRequestDialog(
              context: context,
              onPressed: () {
                NavigationService.pushReplacementNamed(
                  routeName: Routes.ratingPage,
                  args: bookingId,
                );
              },
              title: "Payment Successfull",
              bottomText: "GIVE RATING",
              description:
                  "You have paid \$ ${state.data.amount} to ${state.data.name}, Now give her your ratings & feedback.",
            );
          }
        },
        child: BlocBuilderWrapper<FetchBookingDetailsCubit>(
          builder: (context, state) {
            if (state is CommonSuccessState<BookingDetails>) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(
                  vertical: CustomTheme.pageTopPadding,
                  horizontal: CustomTheme.horizontalPadding,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Summary",
                      style:
                          appTextTheme.bodyLargeSemiBold.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 20.hp),
                    _UserSummary(details: state.data),
                    SizedBox(height: 18.hp),
                    KeyValueTile(
                      title: "Total",
                      value: "\$ ${state.data.totalAmount}",
                      useSpacer: true,
                      valueStyle: appTextTheme.bodySemiBold.copyWith(
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(),
                    CustomRoundedButtom(
                      title: "PROCEED FOR PAYMENT",
                      onPressed: () {
                        showSelectPaymentMethodBottomSheet(
                          context: context,
                          onConfirmed: (value) {
                            final CreatePaymentParam param = CreatePaymentParam(
                              amount: state.data.totalAmount,
                              bookingId: bookingId,
                              method: value,
                              name: state.data.nannyName,
                            );
                            context
                                .read<CreatePaymentCubit>()
                                .createPayment(param);
                          },
                        );
                      },
                      color: CustomTheme.primaryColor,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: context.bottomViewPadding + 20.hp),
                  ],
                ),
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

class _UserSummary extends StatelessWidget {
  final BookingDetails details;
  const _UserSummary({required this.details});

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: CustomTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          KeyValueTile(
            title: "Nany's Name:",
            value: details.nannyName,
            useSpacer: true,
            valueStyle: appTextTheme.bodySemiBold,
          ),
          KeyValueTile(
            title: "Job Commitment:",
            value: details.jobCommitment,
            useSpacer: true,
            valueStyle: appTextTheme.bodySemiBold,
          ),
          KeyValueTile(
            title: "Start Date:",
            value: Jiffy.parseFromDateTime(details.startDate)
                .format(pattern: "yyyy-MM-dd"),
            valueStyle: appTextTheme.bodySemiBold,
            useSpacer: true,
          ),
          KeyValueTile(
            title: "Working Days:",
            value:
                "${details.daysWorked} ${details.daysWorked == 1 ? "Day" : "Days"}",
            useSpacer: true,
            valueStyle: appTextTheme.bodySemiBold,
          ),
          KeyValueTile(
            title: "Total Hours:",
            value: "${details.hoursWorked}/hr",
            valueStyle: appTextTheme.bodySemiBold,
            useSpacer: true,
          ),
          KeyValueTile(
            title: "Hourly Rate:",
            value: "${details.hourlyRate}\$/hr",
            valueStyle: appTextTheme.bodySemiBold,
            useSpacer: true,
          ),
        ],
      ),
    );
  }
}
