import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/model/city.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';

class FetchCityCubit extends Cubit<CommonState> {
  final SkillsRepository repository;
  FetchCityCubit({required this.repository})
      : super(CommonInitialState());

  fetchCity() async {
    emit(CommonLoadingState());
    final res = await repository.fetchCities();
    res.fold(
      (err) => emit(CommonErrorState(message: err)),
      (data) => emit(CommonSuccessState<List<City>>(data: data)),
    );
  }
}
