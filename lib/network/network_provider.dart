
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_interceptors.dart';
import 'logging_interceptor.dart';



final networkProvider = Provider<Dio>((ref) {
  Dio dio = Dio();

  dio.options.connectTimeout = const Duration(seconds: 25);
  dio.options.receiveTimeout = const Duration(seconds: 25);

  dio.interceptors.add(AppInterceptors());
  dio.interceptors.add(LoggingInterceptor());


  return dio;
});

final dioUnauthenticatedProvider = Provider<Dio>((ref) {
  Dio dio = Dio();

  // dio.options.baseUrl = ;
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);

  dio.interceptors.add(LoggingInterceptor());

  return dio;
});