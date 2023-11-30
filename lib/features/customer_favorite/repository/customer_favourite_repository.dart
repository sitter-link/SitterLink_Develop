import 'package:dartz/dartz.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';

class FavoriteRepository {
  final ApiProvider apiProvider;
  final Env env;

  FavoriteRepository({
    required this.apiProvider,
    required this.env,
  });

  final List<Nanny> _nannies = [];

  List<Nanny> get nannies => _nannies;

  Future<Either<String, void>> addToFavourite(int nannyId) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/add-to-favourites",
        {"id": nannyId},
      );

      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> removeFromFavourite(int nannyId) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/remove-from-favourites",
        {"id": nannyId},
      );

      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Nanny>>> favoriteNannies(
      {String? fullName}) async {
    try {
      final Map<String, dynamic> query = {};

      if (fullName != null) {
        query["fullname"] = fullName;
      }
      final res = await apiProvider.get(
        "${env.baseUrl}/user/list-favourites",
        queryParams: query,
      );
      final items = List.from(res["data"])
          .map((e) => Nanny.fromFavoriteApiMap(e))
          .toList();
      _nannies.clear();
      _nannies.addAll(items);
      return Right(_nannies);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
