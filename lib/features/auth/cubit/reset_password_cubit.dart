import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class ResetPasswordCubit extends Cubit<CommonState> {
  final UserRepository repository;
  ResetPasswordCubit({required this.repository}) : super(CommonInitialState());

  resetPassword({required String phone, required String password}) async {
    emit(CommonLoadingState());
    final res =
        await repository.resetPassword(password: password, phone: phone);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(data: null)),
    );
  }
}
