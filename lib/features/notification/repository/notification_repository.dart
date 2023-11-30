import 'package:dartz/dartz.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/features/notification/model/notification.dart';

class NotificationRepository {
  final ApiProvider apiProvider;
  final Env env;

  NotificationRepository({
    required this.apiProvider,
    required this.env,
  });

  Future<Either<String, List<AppNotification>>> fetchNotification() async {
    try {
      final res = await apiProvider.get("${env.baseUrl}/notification/list");
      final items = List.from(res["data"])
          .map((e) => AppNotification.fromMap(e))
          .toList();
      return Right(items);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
