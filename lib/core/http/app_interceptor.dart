import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rankai/core/utils/print.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Print.magenta("URL >> ${options.uri}");
    Print.magenta("Data >> ${options.data}");

    options.data['model'] = 'gpt-3.5-turbo';
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Print.red(
      "Response err >> ${err.message}, Endpoint = ${err.requestOptions.path}",
    );

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Print.green("Response data >> ${response.data}");
    super.onResponse(response, handler);
  }
}
