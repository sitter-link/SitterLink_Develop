import 'package:nanny_app/core/model/availability.dart';
import 'package:nanny_app/core/model/city.dart';
import 'package:nanny_app/core/model/day.dart';
import 'package:nanny_app/core/model/experience.dart';
import 'package:nanny_app/core/model/language.dart';
import 'package:nanny_app/core/model/skill.dart';

class ProfileSetupInfo {
  final List<Availability> commitementType;
  final List<City> cities;
  final List<Day> days;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<Language> languages;

  ProfileSetupInfo({
    required this.commitementType,
    required this.cities,
    required this.days,
    required this.skills,
    required this.experiences,
    required this.languages,
  });
}
