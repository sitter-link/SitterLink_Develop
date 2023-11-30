import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class UpdateAvatarCubit extends Cubit<CommonState> {
  final UserRepository repository;
  UpdateAvatarCubit({required this.repository}) : super(CommonInitialState());

  updateAvatar(File file) async {
    emit(CommonLoadingState());
    final res = await repository.updateAvatar(avatar: file);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(data: null)),
    );
  }
}
