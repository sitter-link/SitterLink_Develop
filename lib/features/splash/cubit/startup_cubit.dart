import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';
import 'package:nanny_app/features/splash/model/start_up_data.dart';

class StartUpCubit extends Cubit<CommonState> {
  UserRepository userRepository;
  StartUpCubit({required this.userRepository}) : super(CommonInitialState());

  fetchData() async {
    emit(CommonLoadingState());
    await Future.delayed(const Duration(seconds: 2));

    final _ = await userRepository.initialize();
    emit(
      CommonSuccessState<StartUpData>(
        data: StartUpData(
          isLoggedIn: userRepository.user.value != null,
          user: userRepository.user.value,
        ),
      ),
    );
  }
}
