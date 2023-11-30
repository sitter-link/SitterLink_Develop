import 'package:flutter/foundation.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:nanny_app/core/database/database_service.dart';
import 'package:nanny_app/core/model/access_token.dart';

class DioAuthTokenStorage implements TokenStorage<OAuth2Token> {
  final DatabaseService databaseService;

  DioAuthTokenStorage({required this.databaseService});

  @override
  Future<void> delete() {
    return databaseService.removeAppToken();
  }

  @override
  Future<OAuth2Token?> read() async {
    final appToken = await databaseService.getAppToken();
    if (appToken?.accessToken.isNotEmpty ?? false) {
      if (kDebugMode) {
        print("App Token---------------------------");
        print(appToken?.accessToken);
      }
      return OAuth2Token(
        accessToken: appToken!.accessToken,
        refreshToken: appToken.refreshToken,
      );
    } else {
      return null;
    }
  }

  @override
  Future<void> write(OAuth2Token token) async {
    final _ = await databaseService.saveAppToken(
      AppToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken ?? "",
      ),
    );
  }
}
