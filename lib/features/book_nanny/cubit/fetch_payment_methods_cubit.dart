import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_history/model/payment_method.dart';

class FetchPaymentMethodsCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  FetchPaymentMethodsCubit({required this.repository})
      : super(CommonInitialState());

  fetchPaymentMethods() async {
    emit(CommonLoadingState());
    final res = await repository.fetchPaymentMethods();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<List<PaymentMethod>>(data: data)),
    );
  }
}
