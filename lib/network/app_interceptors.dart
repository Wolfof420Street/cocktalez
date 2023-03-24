import 'dart:async';

import 'package:cocktalez/constants/router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' as g;

import '../app/components/custom_error_dialog.dart';
import 'network_error_helper.dart';

class AppInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
   

    options.headers.addAll({'content-type': 'application/json'});
    options.headers.addAll({'accept': 'application/json'});

    return handler.next(options);
  }

  @override
  FutureOr<dynamic> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return handler.next(response);
  }

  @override
  FutureOr<dynamic> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      //TODO: lock request and response

      Navigator.pushNamedAndRemoveUntil(
          g.Get.context!, ScreenPaths.splash, (route) => false);

      return;
    }

    String errorMessage = NetworkErrorHandler.handleError(err);

    showErrorDialog(g.Get.context!, errorMessage);

    return handler.next(err);
  }

  

}