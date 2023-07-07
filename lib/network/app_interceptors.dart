import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


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
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
    
      return err.response?.statusMessage;
    } else if (err.response?.statusCode == 403) {
     
     return err.response?.statusMessage;
    } else if (err.response?.statusCode == 404) {
      
     return err.response?.statusMessage;
    } else if (err.response?.statusCode == 500) {
      
     return err.response?.statusMessage;
    } else if (err.response?.statusCode == 503) {
      
     return err.response?.statusMessage;
    }

    String errorMessage = NetworkErrorHandler.handleError(err);

    debugPrint("Network Error message $errorMessage");

    return handler.next(err);
  }

  

}