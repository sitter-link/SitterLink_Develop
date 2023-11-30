import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/api/token_storage.dart';
import 'package:nanny_app/core/database/database_service.dart';
import 'package:nanny_app/core/model/access_token.dart';
import 'package:get_it/get_it.dart';

class DI {
  static final instance = GetIt.instance;

  static Future<void> init({required Env env}) async {
    instance.registerSingleton<Env>(env);

    //Databases
    instance.registerLazySingleton(() => DatabaseService());

    DI.instance.registerSingleton<DioAuthTokenStorage>(
      DioAuthTokenStorage(databaseService: DI.instance()),
    );

    DI.instance.registerSingleton<Fresh<OAuth2Token>>(
      Fresh.oAuth2(
        tokenStorage: DI.instance<DioAuthTokenStorage>(),
        httpClient: Dio(BaseOptions(receiveDataWhenStatusError: true)),
        tokenHeader: (token) {
          return {
            'authorization': 'Bearer ${token.accessToken}',
          };
        },
        shouldRefresh: (response) {
          if (response?.statusCode == 401 &&
              response!.data["message"]
                  .toString()
                  .toLowerCase()
                  .contains("expire")) {
            return true;
          } else {
            return false;
          }
        },
        refreshToken: (token, client) async {
          final res = await client.post(
            "${env.baseUrl}/user/auth/token/refresh/",
            data: {
              "refresh": token?.refreshToken,
            },
          );
          final AppToken appToken = AppToken.fromJson(res.data);
          instance<DatabaseService>().saveAppToken(appToken);
          return OAuth2Token(
            accessToken: appToken.accessToken,
            refreshToken: appToken.refreshToken,
          );
        },
      ),
    );

    instance.registerSingleton<Dio>(
      Dio(
        BaseOptions(
          receiveDataWhenStatusError: true,
        ),
      )..interceptors.addAll(
          [
            DI.instance<Fresh<OAuth2Token>>(),
          ],
        ),
    );

    instance.registerSingleton<ApiProvider>(
      ApiProvider(dio: DI.instance()),
    );
  }
}
