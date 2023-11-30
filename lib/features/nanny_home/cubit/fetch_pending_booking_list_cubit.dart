import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/update_booking_status_cubit.dart';
import 'package:nanny_app/features/book_nanny/model/update_booking_status_param.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_history/model/booking.dart';

class FetchPendingBookingListCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;

  final List<Booking> _bookings = [];

  final UpdateBookingStatusCubit updateBookingStatusCubit;
  StreamSubscription? updateBookingStatusStream;

  FetchPendingBookingListCubit({
    required this.repository,
    required this.updateBookingStatusCubit,
  }) : super(CommonInitialState()) {
    updateBookingStatusStream = updateBookingStatusCubit.stream.listen((event) {
      if (event is CommonSuccessState<UpdateBookingStatusParam>) {
        emit(CommonLoadingState());
        final index = _bookings.indexWhere((e) => e.id == event.data.bookingId);
        if (index != -1) {
          _bookings[index] =
              _bookings[index].copyWith(status: event.data.status);
        }
        emit(CommonSuccessState<List<Booking>>(data: _bookings));
      }
    });
  }

  fetchBooking() async {
    emit(CommonLoadingState());
    final res = await repository.fetchNannyPendingBooking();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) {
        _bookings.clear();
        _bookings.addAll(data);
        if (data.isNotEmpty) {
          emit(CommonSuccessState<List<Booking>>(data: data));
        } else {
          emit(CommonNoDataState());
        }
      },
    );
  }

  @override
  Future<void> close() {
    updateBookingStatusStream?.cancel();
    return super.close();
  }
}
