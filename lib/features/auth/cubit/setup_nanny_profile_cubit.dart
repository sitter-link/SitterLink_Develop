import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/model/param/setup_profile_param.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class SetupNannyProfileCubit extends Cubit<CommonState> {
  final UserRepository userRepository;
  SetupNannyProfileCubit({required this.userRepository})
      : super(CommonInitialState());

  updateProfile(SetupProfileParam param) async {
    emit(CommonLoadingState());
    final res = await userRepository.setupNannyProfile(param: param);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(data: null)),
    );
  }
}
