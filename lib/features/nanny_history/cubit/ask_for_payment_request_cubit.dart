import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';

class AskForPaymentRequestCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  AskForPaymentRequestCubit({required this.repository})
      : super(CommonInitialState());

  askPayment(int bookingId) async {
    emit(CommonLoadingState());
    final res = await repository.paymentRequest(bookingId);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(data: null)),
    );
  }
}
