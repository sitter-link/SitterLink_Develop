import 'package:dartz/dartz.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';

class NannyRepository {
  final ApiProvider apiProvider;
  final Env env;

  NannyRepository({
    required this.apiProvider,
    required this.env,
  });

  final List<Nanny> _searchedNannies = [];

  List<Nanny> get searchedNannies => _searchedNannies;

  Future<Either<String, List<Nanny>>> searchNannies(
      NannyFilterParam param) async {
    try {
      final res = await apiProvider.post(
        "${env.baseUrl}/user/nanny-search",
        param.toMap(),
      );

      final items =
          List.from(res["data"]).map((e) => Nanny.fromMap(e)).toList();
      _searchedNannies.clear();
      _searchedNannies.addAll(items);
      return Right(_searchedNannies);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Nanny>> fetchNanniesDeatils(int nannyId) async {
    try {
      final res = await apiProvider.get(
        "${env.baseUrl}/user/$nannyId/nannies-detail",
      );

      final items = Nanny.fromMapDetails(res["data"]);
      return Right(items);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
