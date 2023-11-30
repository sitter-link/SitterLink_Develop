import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/cancel_booking_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_payment_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_review_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/update_booking_status_cubit.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_history/cubit/fetch_customer_booking_history_cubit.dart';
import 'package:nanny_app/features/nanny_history/cubit/ask_for_payment_request_cubit.dart';
import 'package:nanny_app/features/nanny_history/widgets/nanny_history_body.dart';

class NannyHistoryView extends StatelessWidget {
  const NannyHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CancelBookingCubit(
            repository: context.read<BookNannyRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FetchCustomerBookingHistoryCubit(
            addToFavoruteCubit: context.read<AddToFavouriteCubit>(),
            removeToFavoruteCubit: context.read<RemoveFromFavouriteCubit>(),
            repository: context.read<BookNannyRepository>(),
            cancelBookingCubit: context.read<CancelBookingCubit>(),
            createPaymentCubit: context.read<CreatePaymentCubit>(),
            createReviewCubit: context.read<CreateReviewCubit>(),
            updateBookingStatusCubit: context.read<UpdateBookingStatusCubit>(),
          )..fetchBookings(),
        ),
        BlocProvider(
          create: (context) => AskForPaymentRequestCubit(
            repository: context.read<BookNannyRepository>(),
          ),
        )
      ],
      child: const NannyHistoryBody(),
    );
  }
}
