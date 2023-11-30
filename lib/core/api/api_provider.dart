// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nanny_app/core/error_handling/exception.dart';
import 'package:nanny_app/core/routes/routes.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/utils/text_utils.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

bool isTokenExpiryHandled = false;

Future<void> handleTokenExpiry(DioException exception) async {
  if (exception.response?.data case {"message": String msg}) {
    if (isTokenExpiryHandled == false &&
        exception.response?.data["error"] == true &&
        msg.contains("token") &&
        msg.contains("expire")) {
      isTokenExpiryHandled = true;
      SnackBarUtils.showSuccessMessage(
        context: NavigationService.context,
        message: "Session expired!!",
      );
      NavigationService.pushNamedAndRemoveUntil(routeName: Routes.lookingFor);
    }
    Future.delayed(
      const Duration(seconds: 4),
      () {
        isTokenExpiryHandled = false;
      },
    );
  }
}

class ApiProvider {
  final Dio dio;

  ApiProvider({
    required this.dio,
  });

  Future<Map<String, dynamic>> post(
    String url,
    dynamic body, {
    Map<String, dynamic>? queryParam,
    bool isRefreshRequest = false,
    Map<String, dynamic>? headers,
  }) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        ...?headers,
      };

      queryParam = {
        ...?queryParam,
      };

      final dynamic response = await dio.post(
        url,
        data: body,
        queryParameters: queryParam,
        options: Options(headers: header),
      );
      log((response as Response).realUri.toString());
      responseJson = _response(response, url);
    } on DioException catch (e) {
      log('------- DIO EXCEPTIOn');
      log(e.response?.data.toString() ?? "");
      handleTokenExpiry(e);
      responseJson = await _handleErrorResponse(e);
    } catch (e) {
      log('-------  EXCEPTION');
      log(e.toString());
      if (kDebugMode) {
        print(e);
      }
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, dynamic body,
      {bool isRefreshRequest = false}) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      final dynamic response = await dio.patch(
        url,
        queryParameters: {},
        data: body,
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      handleTokenExpiry(e);
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body,
      {String token = '', bool isRefreshRequest = false}) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      final dynamic response = await dio.put(
        url,
        data: body,
        queryParameters: {},
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioException catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> get(String url,
      {bool isRefreshRequest = false,
      Map<String, dynamic>? queryParams}) async {
    dynamic responseJson;

    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };

      queryParams = {
        ...?queryParams,
        "channel": "POS",
      };

      final dynamic response = await dio.get(
        url,
        options: Options(
          headers: header,
        ),
        queryParameters: queryParams,
      );

      responseJson = _response(response, url, cacheResult: true);
    } on DioException catch (e, s) {
      handleTokenExpiry(e);
      responseJson = await _handleErrorResponse(e);
      Logger().e(e);
      Logger().d(s);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {dynamic body}) async {
    dynamic responseJson;
    try {
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
      };
      final dynamic response = await dio.delete(
        url,
        data: body,
        queryParameters: {},
        options: Options(headers: header),
      );
      responseJson = await _response(response, url);
      responseJson['status'] = response.statusCode;
    } on DioException catch (e) {
      handleTokenExpiry(e);
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  upload({required String url, required File file, required String key}) async {
    try {
      final String type = lookupMimeType(file.path)!.split('/').first;
      final Map<String, dynamic> header = {
        "Content-Type": type,
        "Content-Length": file.readAsBytesSync().length,
        'accept': 'application/json',
        'origin': '*',
      };

      final Response<dynamic> response =
          await Dio(BaseOptions(receiveDataWhenStatusError: true)).put<dynamic>(
        url,
        data: file.openRead(),
        options: Options(
          headers: header,
        ),
      );

      if (kDebugMode) {
        print(response.data.toString());
      }
      return _response(response, url);
    } on DioException catch (e) {
      handleTokenExpiry(e);
      throw const ServerFailure(
        message: 'Unable to upload file',
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  download(String url, String localPath) async {
    // dynamic responseJson = <String, dynamic>{};
    try {
      final Response<dynamic> response = await dio.get<dynamic>(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              if (status == null) {
                return false;
              }
              return status < 500;
            }),
      );
      final File file = File(localPath);
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      final Map<String, dynamic> res = {
        "data": file,
        "statusCode": 200,
      };
      return res;
    } on DioException catch (e) {
      handleTokenExpiry(e);
      Logger().e(e);
      // responseJson = await _handleErrorResponse(e);
    } catch (e) {
      Logger().e("Error in downlodng");
    }
  }

  _handleErrorResponse(DioException e) async {
    if (e.toString().toLowerCase().contains("socketexception")) {
      throw const ConnectionFailure(message: 'No Internet connection');
    } else {
      if (e.response != null) {
        return await _response(e.response!, "");
      } else {
        throw const ServerFailure(
            message: 'An error occurred while fetching data.');
      }
    }
  }

  Future<Map<String, dynamic>> _response(Response response, String url,
      {bool cacheResult = false}) async {
    final responseJson = <String, dynamic>{};
    responseJson['data'] = response.data;

    responseJson['statusCode'] = response.statusCode;
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        return responseJson;
      case 400:
        throw ServerFailure(
          message: getErrorMessage(response.data),
          statusCode: response.statusCode,
        );
      case 401:
      case 402:
        throw ServerFailure(
          message: getErrorMessage(response.data),
          statusCode: response.statusCode,
        );
      case 403:
        throw ServerFailure(
          message: getErrorMessage(response.data),
          statusCode: response.statusCode,
        );
      case 404:
        throw ServerFailure(
          message: getErrorMessage(response.data),
          statusCode: response.statusCode,
        );
      case 409:
        throw ServerFailure(
          message: getErrorMessage(response.data),
          statusCode: response.statusCode,
        );
      case 422:
        responseJson['error'] = getErrorMessage(response.data);
        throw ServerFailure(
          message: getErrorMessage(response.data),
          statusCode: response.statusCode,
        );
      case 500:
        throw ServerFailure(
          message: getErrorMessage(response.data),
          statusCode: response.statusCode,
        );
      default:
        throw ServerFailure(
          message: 'Error occured while Communication with Server',
          statusCode: response.statusCode,
        );
    }
  }

  String getErrorMessage(dynamic res) {
    try {
      debugPrint("-------------------GET ERROR ------------------");
      if (res case {"info": {"object": {"message": {"Message": String msg}}}}) {
        return msg;
      } else if (res case {"message": String msg}) {
        return msg.capitalize();
      } else if (res case {"error": String msg}) {
        return msg;
      } else if (res case {"error": [String msg]}) {
        return msg;
      } else if (res case {"error": {"message": String msg}}) {
        return msg;
      } else if (res case {"detail": String msg}) {
        return msg;
      } else {
        return "Internal Server Error";
      }
    } catch (e) {
      return e.toString();
    } finally {
      if (kDebugMode) {
        print('-------- MESSAGE');
        print(res);
      }
    }
  }
}
