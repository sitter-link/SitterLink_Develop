import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/fetch_booking_details_cubit.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_history/widgets/payment_body.dart';

class PaymentView extends StatelessWidget {
  final int bookingId;
  const PaymentView({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchBookingDetailsCubit(
            repository: context.read<BookNannyRepository>(),
          )..fetchDetails(bookingId),
        ),
      ],
      child: PaymentBody(bookingId: bookingId),
    );
  }
}
