import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_history/model/booking_details.dart';

class FetchBookingDetailsCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  FetchBookingDetailsCubit({required this.repository})
      : super(CommonInitialState());

  fetchDetails(int bookingId) async {
    emit(CommonLoadingState());
    final res = await repository.fetchBookingDetails(bookingId);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<BookingDetails>(data: data)),
    );
  }
}
