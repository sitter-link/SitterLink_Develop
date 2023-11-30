import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/cancel_booking_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_payment_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_review_cubit.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/update_booking_status_cubit.dart';
import 'package:nanny_app/features/book_nanny/model/create_payment_param.dart';
import 'package:nanny_app/features/book_nanny/model/update_booking_status_param.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_favorite/cubit/add_to_favoutite_cubit.dart';
import 'package:nanny_app/features/customer_favorite/cubit/remove_from_favourite_cubit.dart';
import 'package:nanny_app/features/customer_history/model/booking.dart';
import 'package:nanny_app/features/customer_history/model/create_rating_param.dart';

class FetchCustomerBookingHistoryCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;

  final List<Booking> _bookings = [];

  AddToFavouriteCubit addToFavoruteCubit;

  StreamSubscription? addToFavoriteStream;

  RemoveFromFavouriteCubit removeToFavoruteCubit;

  StreamSubscription? removeToFavoriteStream;

  CancelBookingCubit cancelBookingCubit;

  StreamSubscription? cancelBookingStream;

  CreatePaymentCubit createPaymentCubit;

  StreamSubscription? createPaymentStream;

  CreateReviewCubit createReviewCubit;

  StreamSubscription? createReviewStream;

  UpdateBookingStatusCubit updateBookingStatusCubit;

  StreamSubscription? updateBookingStatusStream;

  FetchCustomerBookingHistoryCubit({
    required this.repository,
    required this.addToFavoruteCubit,
    required this.removeToFavoruteCubit,
    required this.cancelBookingCubit,
    required this.createPaymentCubit,
    required this.createReviewCubit,
    required this.updateBookingStatusCubit,
  }) : super(CommonInitialState()) {
    addToFavoriteStream = addToFavoruteCubit.stream.listen((event) {
      if (event is CommonSuccessState<int>) {
        emit(CommonLoadingState());
        final index = _bookings.indexWhere((e) => e.nanny.id == event.data);
        if (index != -1) {
          _bookings[index] = _bookings[index].copyWith(hasBeenFavorite: true);
        }
        emit(CommonSuccessState<List<Booking>>(data: _bookings));
      }
    });

    removeToFavoriteStream = removeToFavoruteCubit.stream.listen((event) {
      if (event is CommonSuccessState<int>) {
        emit(CommonLoadingState());
        final index = _bookings.indexWhere((e) => e.nanny.id == event.data);
        if (index != -1) {
          _bookings[index] = _bookings[index].copyWith(hasBeenFavorite: false);
        }
        emit(CommonSuccessState<List<Booking>>(data: _bookings));
      }
    });

    cancelBookingStream = cancelBookingCubit.stream.listen((event) {
      if (event is CommonSuccessState<int>) {
        emit(CommonLoadingState());
        _bookings.removeWhere((e) => e.id == event.data);
        if (_bookings.isNotEmpty) {
          emit(CommonSuccessState<List<Booking>>(data: _bookings));
        } else {
          emit(CommonNoDataState());
        }
      }
    });

    createPaymentStream = createPaymentCubit.stream.listen((event) {
      if (event is CommonSuccessState<CreatePaymentParam>) {
        emit(CommonLoadingState());
        final index = _bookings.indexWhere((e) => e.id == event.data.bookingId);
        if (index != -1) {
          _bookings[index] = _bookings[index].copyWith(hasPaymentDone: true);
        }
        emit(CommonSuccessState<List<Booking>>(data: _bookings));
      }
    });

    createReviewStream = createReviewCubit.stream.listen((event) {
      if (event is CommonSuccessState<CreateRatingParam>) {
        emit(CommonLoadingState());
        final index = _bookings.indexWhere((e) => e.id == event.data.bookingId);
        if (index != -1) {
          _bookings[index] = _bookings[index].copyWith(hasReviewed: true);
        }
        emit(CommonSuccessState<List<Booking>>(data: _bookings));
      }
    });

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

  fetchBookings({String? fullName}) async {
    emit(CommonLoadingState());
    final res = await repository.fetchCustomerBookingHistory(
      fullName: fullName,
    );
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
    addToFavoriteStream?.cancel();
    removeToFavoriteStream?.cancel();
    cancelBookingStream?.cancel();
    createPaymentStream?.cancel();
    createReviewStream?.cancel();
    updateBookingStatusStream?.cancel();
    return super.close();
  }
}
