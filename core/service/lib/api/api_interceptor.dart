

import 'package:auth/auth.dart';
import 'package:common_dependency/common_dependency.dart';
import 'package:flutter/cupertino.dart';


class ApiInterceptor extends QueuedInterceptor {
  final Dio dio;
  final MasterSharedPreferences masterSharedPreferences;
  ApiInterceptor(this.dio, this.masterSharedPreferences) : super();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey("Authorization")) {
      try{
        final userTokenModel = await masterSharedPreferences.getUserTokenModel();
        if (userTokenModel != null) {
          options.headers['Authorization'] = 'Bearer ${userTokenModel.token}';
        } else {
          debugPrint("pesan on request interceptor userToken null");
        }
      }catch(e){
        debugPrint("${e.toString()}");
      }

    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("masuk sini ${err.response!.statusCode}");
    if (err.response?.statusCode == 401) {
      try {
        final userTokenModel = await masterSharedPreferences.getUserTokenModel();
        final newToken = (await _getNewToken(userTokenModel!.refreshToken));
        handler.resolve(
          await _retry(
            err.requestOptions,
            newToken.refreshToken,
          ),
        );

      } catch (e) {
        handler.next(err);
      }

    } else {
      return handler.next(err);
    }
  }

  Future<RefreshTokenModel> _getNewToken(String refreshToken) async {
    final uri = urlNewToken;
    try{
      final response = await dio.post(uri, data: {
        "refresh_token": refreshToken
      });
      final result = RefreshTokenModel.fromJson(response.data["data"]);
      await masterSharedPreferences.setUserTokenModel(UserTokenModel(token: result.token, refreshToken: result.refreshToken));
      return result;
    }catch(e){
      rethrow;
    }

  }

  Future<Response<dynamic>> _retry(
      RequestOptions requestOptions, String accessToken) async {
    final options = Options(
      method: requestOptions.method,
      headers: <String, Object?>{'Authorization': 'Bearer $accessToken'},
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
