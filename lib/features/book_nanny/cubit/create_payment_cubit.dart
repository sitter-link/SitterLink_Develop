import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/book_nanny/model/create_payment_param.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';

class CreatePaymentCubit extends Cubit<CommonState> {
  final BookNannyRepository repository;
  CreatePaymentCubit({required this.repository}) : super(CommonInitialState());

  createPayment(CreatePaymentParam param) async {
    emit(CommonLoadingState());
    final res = await repository.createPayment(param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<CreatePaymentParam>(data: param)),
    );
  }
}
