import 'package:dartz/dartz.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/core/model/availability.dart';
import 'package:nanny_app/core/model/city.dart';
import 'package:nanny_app/core/model/day.dart';
import 'package:nanny_app/core/model/experience.dart';
import 'package:nanny_app/core/model/language.dart';
import 'package:nanny_app/core/model/skill.dart';

class SkillsRepository {
  final ApiProvider apiProvider;
  final Env env;

  SkillsRepository({
    required this.apiProvider,
    required this.env,
  });

  final List<Availability> _availability = [];
  List<Availability> get availability => _availability;

  final List<City> _city = [];
  List<City> get city => _city;

  final List<Day> _days = [];
  List<Day> get days => _days;

  final List<Skill> _skills = [];
  List<Skill> get skills => _skills;

  final List<Experience> _experiences = [];
  List<Experience> get experiences => _experiences;

  final List<Language> _languages = [];
  List<Language> get languages => _languages;

  Future<Either<String, List<Availability>>> fetchAvailability(
      {bool forceUpdate = false}) async {
    try {
      if (_availability.isNotEmpty && forceUpdate == false) {
        return Right(_availability);
      }
      final res = await apiProvider.get("${env.baseUrl}/skills/availiability");
      final items =
          List.from(res["data"]).map((e) => Availability.fromMap(e)).toList();
      _availability.clear();
      _availability.addAll(items);
      return Right(_availability);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<City>>> fetchCities(
      {bool forceUpdate = false}) async {
    try {
      if (_city.isNotEmpty && forceUpdate == false) {
        return Right(_city);
      }
      final res = await apiProvider.get("${env.baseUrl}/skills/cities/list");
      final items = List.from(res["data"]).map((e) => City.fromMap(e)).toList();
      _city.clear();
      _city.addAll(items);
      return Right(_city);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Day>>> fetchDays(
      {bool forceUpdate = false}) async {
    try {
      if (_days.isNotEmpty && forceUpdate == false) {
        return Right(_days);
      }
      final res = await apiProvider.get("${env.baseUrl}/skills/days");
      final items = List.from(res["data"]).map((e) => Day.fromMap(e)).toList();
      _days.clear();
      _days.addAll(items);
      return Right(_days);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Skill>>> fetchSkills(
      {bool forceUpdate = false}) async {
    try {
      if (_skills.isNotEmpty && forceUpdate == false) {
        return Right(_skills);
      }
      final res = await apiProvider.get("${env.baseUrl}/skills/list");
      final items =
          List.from(res["data"]).map((e) => Skill.fromMap(e)).toList();
      _skills.clear();
      _skills.addAll(items);
      return Right(_skills);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Experience>>> fetchExperiences(
      {bool forceUpdate = false}) async {
    try {
      if (_experiences.isNotEmpty && forceUpdate == false) {
        return Right(_experiences);
      }
      final res =
          await apiProvider.get("${env.baseUrl}/skills/experience-list");
      final items =
          List.from(res["data"]).map((e) => Experience.fromMap(e)).toList();
      _experiences.clear();
      _experiences.addAll(items);
      return Right(_experiences);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Language>>> fetchLanguages(
      {bool forceUpdate = false}) async {
    try {
      if (_languages.isNotEmpty && forceUpdate == false) {
        return Right(_languages);
      }
      final res = await apiProvider.get("${env.baseUrl}/skills/languages");
      final items =
          List.from(res["data"]).map((e) => Language.fromMap(e)).toList();
      _languages.clear();
      _languages.addAll(items);
      return Right(_languages);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
