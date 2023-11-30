import 'package:dartz/dartz.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/features/rating/model/review.dart';

class RatingRepository {
  final ApiProvider apiProvider;
  final Env env;

  RatingRepository({
    required this.apiProvider,
    required this.env,
  });

  Future<Either<String, List<Review>>> fetchReviews() async {
    try {
      final res = await apiProvider.get("${env.baseUrl}/booking/review/list");
      final items =
          List.from(res["data"]).map((e) => Review.fromMap(e)).toList();
      return Right(items);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
