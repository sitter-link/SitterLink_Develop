import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/model/param/login_param.dart';
import 'package:nanny_app/features/auth/model/user.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class LoginCubit extends Cubit<CommonState> {
  final UserRepository repository;

  LoginCubit({required this.repository}) : super(CommonInitialState());

  login(LoginParam param) async {
    emit(CommonLoadingState());
    final res = await repository.login(param: param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<User>(data: data)),
    );
  }
}
