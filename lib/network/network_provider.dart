import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_interceptors.dart';
import 'logging_interceptor.dart';

import 'package:dio/adapter.dart';

final networkProvider = Provider<Dio>((ref) {
  Dio dio = Dio();

  dio.options.connectTimeout = 10000;
  dio.options.receiveTimeout = 10000;

  dio.interceptors.add(AppInterceptors());
  dio.interceptors.add(LoggingInterceptor());

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
  
    return client;
  };


  return dio;
});

final dioUnauthenticatedProvider = Provider<Dio>((ref) {
  Dio dio = Dio();

  // dio.options.baseUrl = ;
  dio.options.connectTimeout = 10;
  dio.options.receiveTimeout = 10;

  dio.interceptors.add(LoggingInterceptor());

  return dio;
});