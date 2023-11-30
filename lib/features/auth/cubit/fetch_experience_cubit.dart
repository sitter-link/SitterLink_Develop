import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/model/experience.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';

class FetchExperiencesCubit extends Cubit<CommonState> {
  final SkillsRepository repository;
  FetchExperiencesCubit({required this.repository})
      : super(CommonInitialState());

  fetchExperience() async {
    emit(CommonLoadingState());
    final res = await repository.fetchExperiences();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<List<Experience>>(data: data)),
    );
  }
}
