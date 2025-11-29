import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/endpoints.dart';

/// Lightweight ApiClient that centralizes Dio usage and basic HTTP error handling.
///
/// - Uses a singleton pattern (factory) so the same Dio instance and interceptors
///   are reused across the app.
/// - Exposes a generic `get<T>` method which accepts an optional `decoder`
///   function to convert response JSON into typed objects.
/// - Maps non-200 HTTP responses into [ApiException].
class ApiClient {
  ApiClient._internal({String? baseUrl}) {
    final options = BaseOptions(
      baseUrl: baseUrl ?? Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    // Add logging interceptor in debug mode for easier troubleshooting.
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          logPrint: (obj) => log(obj.toString(), name: 'ApiClient'),
        ),
      );
    }

    // Generic interceptor for error normalization
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException err, ErrorInterceptorHandler handler) {
        // Allow the caller to receive a normalized ApiException
        handler.next(err);
      },
    ));
  }

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient({String? baseUrl}) {
    if (baseUrl != null) {
      // If caller provides a baseUrl we return a new configured instance.
      return ApiClient._internal(baseUrl: baseUrl);
    }
    return _instance;
  }

  late final Dio _dio;

  Dio get dio => _dio;

  /// Generic GET helper.
  ///
  /// - [path] is appended to the configured BaseUrl.
  /// - [queryParameters] are forwarded to Dio.
  /// - [decoder] is an optional function that transforms the raw response body
  ///   into an object of type `T`. If omitted, the raw `response.data` is
  ///   returned and cast to `T`.
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic json)? decoder,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      final status = response.statusCode ?? 0;

      if (status < 200 || status >= 300) {
        throw ApiException(
          message: 'Request failed',
          statusCode: status,
          detail: response.statusMessage,
        );
      }

      final data = response.data;

      if (decoder != null) {
        return decoder(data);
      }

      return data as T;
    } on DioException catch (err) {
      // Convert DioError to ApiException so callers don't need to depend on Dio
      if (err.type == DioExceptionType.connectionTimeout ||
          err.type == DioExceptionType.receiveTimeout ||
          err.type == DioExceptionType.sendTimeout) {
        throw ApiException(
          message: 'Request timed out',
          statusCode: 408,
          error: err,
        );
      }

      if (err.response != null) {
        final res = err.response!;
        throw ApiException(
          message: 'HTTP ${res.statusCode}',
          statusCode: res.statusCode,
          detail: res.statusMessage,
          error: err,
        );
      }

      throw ApiException(
        message: err.message ?? 'Network error',
        error: err,
      );
    } catch (err, st) {
      // Any other errors
      throw ApiException(
        message: 'Unexpected error',
        error: err,
        stackTrace: st,
      );
    }
  }

  static Future<void> initCache() async {
    final dir = await getApplicationDocumentsDirectory();
    final cacheStore = HiveCacheStore(
      dir.path,
      hiveBoxName: 'cocktales_cache',
    );

    final cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.refreshForceCache,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 7),
    );

    _instance.dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }
}

/// Simple domain-level API exception used by the app to represent HTTP / network
/// problems. It intentionally avoids exposing Dio types publicly.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? detail;
  final Object? error;
  final StackTrace? stackTrace;

  ApiException({
    this.message = 'ApiException',
    this.statusCode,
    this.detail,
    this.error,
    this.stackTrace,
  });

  @override
  String toString() {
    final code = statusCode != null ? ' (status: $statusCode)' : '';
    final d = detail != null ? ' detail: $detail' : '';
    return 'ApiException: $message$code$d';
  }
}
