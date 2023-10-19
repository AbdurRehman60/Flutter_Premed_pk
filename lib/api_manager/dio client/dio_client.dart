import 'package:dio/dio.dart';
import 'package:premedpk_mobile_app/utils/secure_storage.dart';
import 'package:premedpk_mobile_app/utils/shared_prefrences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'endpoints.dart';

class DioClient {
  static BaseOptions options = BaseOptions(
    baseUrl: Endpoints.serverURL,
    connectTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.receiveTimeout,
  );

  final Dio _dio = Dio(options);

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          if (response.data["header"]["errorCode"] == 401 &&
              await SecureStorage()
                  .secStorage
                  .containsKey(key: 'refreshToken')) {
            if (await refreshToken()) {
              return handler.resolve(await _retry(response.requestOptions));
            }
          }
          return handler.next(response);
        },
      ),
    );
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String accessToken = prefs.getString("accessToken") ?? '';

    final options = Options(
      method: requestOptions.method,
      headers: {"Authorization": "Bearer $accessToken"},
    );
    print(requestOptions.path);
    print(requestOptions.headers['Authorization']);

    Response r = await _dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);

    print('r success');
    return r;
  }

  Future<bool> refreshToken() async {
    String newAccessToken;
    String newRefreshToken;
    final refreshToken = await SecureStorage().getRefreshToken();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String dsrID = prefs.getString("dsrID") ?? '';

    final Map<String, dynamic> refreshTokenData = {
      "User_ID": dsrID,
      "refreshToken": refreshToken,
    };

    final response =
        await _dio.post(Endpoints.newAccessToken, data: refreshTokenData);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
          Map<String, dynamic>.from(response.data);
      newAccessToken = responseData['body']['accessToken'];
      newRefreshToken = responseData['body']['refreshToken'];

      await UserPreferences().updateToken(newAccessToken);
      await SecureStorage().saveRefreshToken(newRefreshToken);

      return true;
    } else {
      // refresh token is wrong
      // await UserPreferences().updateToken('');
      UserPreferences().removeUser();

      await SecureStorage().removeRefreshToken();
      return false;
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final Response response = await _dio.post(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }
}
