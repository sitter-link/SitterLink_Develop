import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/model/day.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';

class FetchDaysCubit extends Cubit<CommonState> {
  final SkillsRepository repository;
  FetchDaysCubit({required this.repository}) : super(CommonInitialState());

  fetchDaysTimeslots() async {
    emit(CommonLoadingState());
    final res = await repository.fetchDays();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<List<Day>>(data: data)),
    );
  }
}
