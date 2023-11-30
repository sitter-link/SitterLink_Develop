import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/model/skill.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';

class FetchSkillsCubit extends Cubit<CommonState> {
  final SkillsRepository repository;
  FetchSkillsCubit({required this.repository})
      : super(CommonInitialState());

  fetchSkills() async {
    emit(CommonLoadingState());
    final res = await repository.fetchSkills();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<List<Skill>>(data: data)),
    );
  }
}
