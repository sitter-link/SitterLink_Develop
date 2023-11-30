import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';

class CancelBookingCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  CancelBookingCubit({required this.repository}) : super(CommonInitialState());

  cancelBooking(int bookingId) async {
    emit(CommonLoadingState());
    final res = await repository.cancelBooking(bookingId);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<int>(data: bookingId)),
    );
  }
}
