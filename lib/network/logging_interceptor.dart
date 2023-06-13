import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    debugPrint(
      "┌------------------------------------------------------------------------------",
    );
    debugPrint('| Request: ${options.method} ${options.uri}');
    debugPrint('| Body: ${options.data.toString()}');
    debugPrint('| Headers:');
    options.headers.forEach((key, value) {
      debugPrint('|\t$key: $value');
    });
    debugPrint(
      "├------------------------------------------------------------------------------",
    );
    handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    debugPrint("| Response [code ${response.statusCode}]");
    debugPrint("| Body: ${response.data.toString()}");
    debugPrint(
      "└------------------------------------------------------------------------------",
    );
    handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err,
      ErrorInterceptorHandler handler,
      ) async {
    debugPrint("| Error: [code ${err.response?.statusCode ?? 0}]");
    debugPrint("| Error body: ${err.response.toString()}");
    debugPrint(
      "└------------------------------------------------------------------------------",
    );
    handler.next(err); //continue
  }
}