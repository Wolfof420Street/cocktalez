import 'dart:async';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    print(
      "┌------------------------------------------------------------------------------",
    );
    print('| Request: ${options.method} ${options.uri}');
    print('| Body: ${options.data.toString()}');
    print('| Headers:');
    options.headers.forEach((key, value) {
      print('|\t$key: $value');
    });
    print(
      "├------------------------------------------------------------------------------",
    );
    handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    print("| Response [code ${response.statusCode}]");
    print("| Body: ${response.data.toString()}");
    print(
      "└------------------------------------------------------------------------------",
    );
    handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) async {
    print("| Error: [code ${err.response?.statusCode ?? 0}]");
    print("| Error body: ${err.response.toString()}");
    print(
      "└------------------------------------------------------------------------------",
    );
    handler.next(err); //continue
  }
}