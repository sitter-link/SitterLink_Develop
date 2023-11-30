import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/update_booking_status_cubit.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/nanny_home/cubit/fetch_pending_booking_list_cubit.dart';
import 'package:nanny_app/features/nanny_home/widgets/nanny_home_body.dart';

class NannyHomeView extends StatelessWidget {
  const NannyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchPendingBookingListCubit(
        repository: context.read<BookNannyRepository>(),
        updateBookingStatusCubit: context.read<UpdateBookingStatusCubit>(),
      )..fetchBooking(),
      child: const NannyHomeBody(),
    );
  }
}
