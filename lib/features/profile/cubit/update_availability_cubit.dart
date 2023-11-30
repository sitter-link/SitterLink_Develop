import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/features/auth/repository/user_repository.dart';

class UpdateAvailabilityCubit extends Cubit<CommonState> {
  final UserRepository repository;
  UpdateAvailabilityCubit({required this.repository})
      : super(CommonInitialState());

  update({required int day, required List<String> shifts}) async {
    emit(CommonLoadingState());
    final res = await repository.updateAvailability(day: day, shifts: shifts);
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState(data: null)),
    );
  }
}
