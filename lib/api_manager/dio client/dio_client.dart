import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'endpoints.dart';

class DioClient {
  static BaseOptions options = BaseOptions(
    baseUrl: Endpoints.serverURL,
    connectTimeout: Endpoints.connectionTimeout,
    receiveTimeout: Endpoints.receiveTimeout,
  );

  final Dio _dio = Dio(options);
  final cookieJar = CookieJar();
  DioClient() {
    _dio.interceptors.add(
      CookieManager(cookieJar),
    );
  }

  Future<void> _saveCookies(List<Cookie> cookies) async {
    print('saving cookie - ${cookies}');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(
      'cookies',
      cookies.map((cookie) => cookie.toString()).toList(),
    );
  }

  Future<List<Cookie>> _loadCookies() async {
    print("Loading cookies...");

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? cookieStrings = prefs.getStringList('cookies');
    print('cookie✨ - ${cookieStrings}');

    if (cookieStrings != null) {
      return cookieStrings
          .map((cookieString) => Cookie.fromSetCookieValue(cookieString))
          .toList();
    } else {
      return [];
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
      List<Cookie> cookies1 = await _loadCookies();
      options ??= Options();
      options.headers = {
        'cookie': cookies1
            .map((cookie) => '${cookie.name}=${cookie.value}')
            .join('; ')
      };

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
    List<Cookie> cookies1 = await _loadCookies();
    options ??= Options();
    options.headers = {
      'cookie':
          cookies1.map((cookie) => '${cookie.name}=${cookie.value}').join('; ')
    };

    final Response response = await _dio.post(
      uri,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    List<Cookie> cookies =
        await cookieJar.loadForRequest(response.requestOptions.uri);

    await _saveCookies(cookies);
    return response;
  }
}
