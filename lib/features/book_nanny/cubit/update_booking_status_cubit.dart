import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/model/update_booking_status_param.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';

class UpdateBookingStatusCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  UpdateBookingStatusCubit({required this.repository})
      : super(CommonInitialState());

  updateBooking(UpdateBookingStatusParam param) async {
    emit(CommonLoadingState());
    final res = await repository.updateBookingStatus(param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<UpdateBookingStatusParam>(data: param)),
    );
  }
}
