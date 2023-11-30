import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/model/availability.dart';
import 'package:nanny_app/core/model/city.dart';
import 'package:nanny_app/core/model/day.dart';
import 'package:nanny_app/core/model/experience.dart';
import 'package:nanny_app/core/model/language.dart';
import 'package:nanny_app/core/model/profile_setup_info.dart';
import 'package:nanny_app/core/model/skill.dart';
import 'package:nanny_app/core/utils/dartz_extension.dart';
import 'package:nanny_app/features/auth/repository/skills_repository.dart';

class FetchAllProfileSetupInfoCubit extends Cubit<CommonState> {
  final SkillsRepository repository;
  FetchAllProfileSetupInfoCubit({required this.repository})
      : super(CommonInitialState());

  fetchInfo() async {
    emit(CommonLoadingState());
    final res = await Future.wait([
      repository.fetchAvailability(),
      repository.fetchCities(),
      repository.fetchDays(),
      repository.fetchSkills(),
      repository.fetchExperiences(),
      repository.fetchLanguages(),
    ]);
    if (res.every((e) => e.isRight())) {
      final info = ProfileSetupInfo(
        skills: res[3].asRight().cast<Skill>(),
        cities: res[1].asRight().cast<City>(),
        commitementType: res.first.asRight().cast<Availability>(),
        days: res[2].asRight().cast<Day>(),
        experiences: res[4].asRight().cast<Experience>(),
        languages: res[5].asRight().cast<Language>(),
      );
      emit(CommonSuccessState<ProfileSetupInfo>(data: info));
    } else {
      emit(
        CommonErrorState(message: res.firstWhere((e) => e.isLeft()).asLeft()),
      );
    }
  }
}
