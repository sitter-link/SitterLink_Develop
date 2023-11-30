// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:nanny_app/app/env.dart';
import 'package:nanny_app/core/api/api_provider.dart';
import 'package:nanny_app/core/api/token_storage.dart';
import 'package:nanny_app/core/database/database_service.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/core/injector/injection.dart';
import 'package:nanny_app/core/model/access_token.dart';
import 'package:nanny_app/features/auth/model/param/login_param.dart';
import 'package:nanny_app/features/auth/model/param/setup_profile_param.dart';
import 'package:nanny_app/features/auth/model/param/verify_otp_param.dart';
import 'package:nanny_app/features/auth/model/user.dart';

class UserRepository {
  final DatabaseService databaseService;
  final ApiProvider apiProvider;
  final Env env;

  UserRepository({
    required this.databaseService,
    required this.apiProvider,
    required this.env,
  });

  // ---------------------- User ----------------------
  final ValueNotifier<User?> _user = ValueNotifier(null);

  ValueNotifier<User?> get user => _user;

  Future<void> initialize() async {
    final tempUser = await databaseService.getUser();
    _user.value = tempUser;
  }

  Future<void> logout() async {
    _user.value = null;
    await DI.instance<DioAuthTokenStorage>().delete();
    await databaseService.removeUser();
  }

  Future<Either<String, User>> login({required LoginParam param}) async {
    try {
      final res = await apiProvider.post(
        "${env.baseUrl}/user/auth/login/",
        {
          "role": param.role.shortValue,
          "phone_number": param.phone,
          "password": param.password,
        },
      );
      final tempToken = AppToken.fromJson(res["data"]);
      final tempUser = User.fromMap(res["data"]["user"]);
      databaseService.saveAppToken(tempToken);
      DI.instance<Fresh<OAuth2Token>>().setToken(
            OAuth2Token(
              accessToken: tempToken.accessToken,
              refreshToken: tempToken.refreshToken,
            ),
          );
      _user.value = tempUser;
      await databaseService.saveUser(tempUser);

      final firebaseToken = await FirebaseMessaging.instance.getToken();
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/register-device",
        {"token": firebaseToken},
        headers: {
          "Authorization": "Bearer ${tempToken.accessToken}",
        },
      );
      return Right(tempUser);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> register({required VerifyOtpParam param}) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/register",
        param.toMap(),
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> setupNannyProfile(
      {required SetupProfileParam param}) async {
    try {
      final postBody = await param.toApiMap();
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/user-profile",
        postBody,
      );
      final updatedUser = _user.value!.copyWith(hasUserProfile: true);
      _user.value = updatedUser;
      await databaseService.saveUser(updatedUser);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> checkPhoneAvailability(
      {required String phoneNumber, required bool isForgetPassword}) async {
    try {
      final res = await apiProvider.post(
        "${env.baseUrl}/user/check-phone_number",
        {"phone_number": phoneNumber},
      );
      if (isForgetPassword) {
        if (res["data"]["exists"] == true) {
          return const Right(null);
        } else {
          return const Left(
            "This phone number is not available. Please try another phone number",
          );
        }
      } else {
        if (res["data"]["exists"] == true) {
          return const Left(
            "This phone number is not available. Please try another phone number",
          );
        } else {
          return const Right(null);
        }
      }
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> changePhoneNumber(
      {required String newPhoneNumber}) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/change_phone_number",
        {
          "old_phone_number": user.value?.phone,
          "new_phone_number": newPhoneNumber,
        },
      );
      final tempNewUser = user.value?.copyWith(phone: newPhoneNumber);
      await databaseService.saveUser(tempNewUser!);
      user.value = tempNewUser;
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> updateAvatar({required File avatar}) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/change-image",
        {
          "avatar": base64Encode(avatar.readAsBytesSync()),
        },
      );

      final userDetails = await apiProvider.get(
        "${env.baseUrl}/user/${user.value?.id}/detail",
      );

      final newAvatar = userDetails["data"]["avatar"];

      final tempNewUser = user.value?.copyWith(avatar: newAvatar);
      await databaseService.saveUser(tempNewUser!);
      user.value = tempNewUser;
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> updateAvailability({
    required int day,
    required List<String> shifts,
  }) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/change-availabilty",
        {
          "day": day,
          "timeslots": shifts.map((e) => {"slug": e}).toList()
        },
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> resetPassword({
    required String password,
    required String phone,
  }) async {
    try {
      final _ = await apiProvider.post(
        "${env.baseUrl}/user/change-password",
        {"phone_number": phone, "password": password},
      );
      return const Right(null);
    } on Failure catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
