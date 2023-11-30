import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/enum/booking_status.dart';
import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:nanny_app/core/utils/url_launcher.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/cards/user_card.dart';
import 'package:nanny_app/core/widgets/placeholder/user_card_placeholder.dart';
import 'package:nanny_app/core/widgets/text_fields/search_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/cancel_booking_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_history/cubit/fetch_customer_booking_history_cubit.dart';
import 'package:nanny_app/features/customer_history/model/booking.dart';

class CustomerHistoryBody extends StatefulWidget {
  const CustomerHistoryBody({super.key});

  @override
  State<CustomerHistoryBody> createState() => _CustomerHistoryBodyState();
}

class _CustomerHistoryBodyState extends State<CustomerHistoryBody> {
  final TextEditingController _searchController = TextEditingController();
  String lastParam = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "History",
      ),
      body: BlocListenerWrapper<AddToFavouriteCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState) {
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: "Nanny Favorite Successfully",
            );
          }
        },
        child: BlocListenerWrapper<CancelBookingCubit>(
          listener: (context, state) {
            if (state is CommonSuccessState) {
              SnackBarUtils.showSuccessMessage(
                context: context,
                message: "Booking Cancelled Successfully",
              );
            }
          },
          child: BlocListenerWrapper<RemoveFromFavouriteCubit>(
            listener: (context, state) {
              if (state is CommonSuccessState) {
                SnackBarUtils.showSuccessMessage(
                  context: context,
                  message: "Nanny Unfavorite Successfully",
                );
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
                              name: state.data[index].nanny.name,
                              age: state.data[index].nanny.age?.toInt() ?? 0,
                              amountPerHrs:
                                  state.data[index].nanny.perHrsRate.toString(),
                              chipItems: state.data[index].nanny.commitmentType
                                  .map((e) => e.name.capitalize())
                                  .toList(),
                              noOfExperience:
                                  state.data[index].nanny.noOfExperience,
                              country: state.data[index].nanny.country,
                              city: state.data[index].nanny.city,
                              image: state.data[index].nanny.avatar,
                              isFavorite: state.data[index].hasBeenFavorite,
                              favouriteOnTap: () {
                                if (state.data[index].hasBeenFavorite) {
                                  context
                                      .read<RemoveFromFavouriteCubit>()
                                      .unfavourite(state.data[index].nanny.id);
                                } else {
                                  context
                                      .read<AddToFavouriteCubit>()
                                      .favorite(state.data[index].nanny.id);
                                }
                              },
                              bottomSection: switch (state.data[index].status) {
                                BookingStatus.accepted => (state
                                            .data[index].hasPaymentDone &&
                                        state.data[index].hasReviewed)
                                    ? null
                                    : Row(
                                        children: [
                                          if (state.data[index].hasReviewed ==
                                              false)
                                            Expanded(
                                              child: CustomRoundedButtom(
                                                title: "GIVE RATING",
                                                prefixIcon:
                                                    NannyIcon.starOutline,
                                                onPressed: () {
                                                  if (state.data[index]
                                                      .hasPaymentDone) {
                                                    NavigationService.pushNamed(
                                                      routeName:
                                                          Routes.ratingPage,
                                                      args:
                                                          state.data[index].id,
                                                    );
                                                  } else {
                                                    SnackBarUtils
                                                        .showErrorMessage(
                                                      context: context,
                                                      message:
                                                          "Please make payment before reviewing the Nanny",
                                                    );
                                                  }
                                                },
                                                iconSize: 18,
                                                fontSize: 15,
                                                color:
                                                    CustomTheme.secondaryColor,
                                                textColor:
                                                    CustomTheme.primaryColor,
                                              ),
                                            ),
                                          if (state.data[index].hasReviewed ==
                                              false)
                                            const SizedBox(
                                              width: 7,
                                            ),
                                          if (state
                                                  .data[index].hasPaymentDone ==
                                              false)
                                            Expanded(
                                              child: CustomRoundedButtom(
                                                title: "PAY NOW",
                                                prefixIcon: NannyIcon.moneySend,
                                                onPressed: () {
                                                  NavigationService.pushNamed(
                                                    routeName: Routes.payment,
                                                    args: state.data[index].id,
                                                  );
                                                },
                                                iconSize: 18,
                                                fontSize: 15,
                                                color: CustomTheme.primaryColor,
                                                textColor: Colors.white,
                                              ),
                                            ),
                                        ],
                                      ),
                                BookingStatus.pending => Row(
                                    children: [
                                      Expanded(
                                        child: CustomRoundedButtom(
                                          title: "CANCEL REQUEST",
                                          prefixIcon: NannyIcon.cancel,
                                          onPressed: () {
                                            context
                                                .read<CancelBookingCubit>()
                                                .cancelBooking(
                                                    state.data[index].id);
                                          },
                                          iconSize: 18,
                                          fontSize: 15,
                                          color: const Color(0xFFFFEBEF),
                                          textColor: const Color(0xFFFF3358),
                                        ),
                                      ),
                                      SizedBox(width: 8.wp),
                                      CustomIconButton(
                                        icon: NannyIcon.call,
                                        backgroundColor:
                                            CustomTheme.primaryColor,
                                        borderRadius: 8,
                                        onPressed: () {
                                          UrlLauncher.launchPhone(
                                            context: context,
                                            phone: state
                                                .data[index].nanny.phoneNUmber,
                                          );
                                        },
                                        iconColor: Colors.white,
                                        padding: 12,
                                      )
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
      ),
    );
  }
}
