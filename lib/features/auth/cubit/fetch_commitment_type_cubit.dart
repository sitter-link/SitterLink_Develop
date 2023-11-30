import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/model/availability.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';

class FetchCommitmentTypeCubit extends Cubit<CommonState> {
  final SkillsRepository repository;
  FetchCommitmentTypeCubit({required this.repository})
      : super(CommonInitialState());

  fetchTypes() async {
    emit(CommonLoadingState());
    final res = await repository.fetchAvailability();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<List<Availability>>(data: data)),
    );
  }
}
