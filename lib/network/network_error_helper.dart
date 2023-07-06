import 'dart:io';

import 'package:dio/dio.dart';

class NetworkErrorHandler {
  static String handleError(DioException err) {
    String errorMessage = 'Unknown Error.';

    switch (err.runtimeType) {
      case DioException:
        switch (err.type) {
          case DioExceptionType.cancel:
            errorMessage = 'Request was cancelled';
            break;
          case DioExceptionType.connectionTimeout:
            errorMessage = 'Connection timeout';
            break;
          case DioExceptionType.connectionError:
            errorMessage = 'Something went wrong';
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = 'Receive timeout in connection';
            break;
          case DioExceptionType.badResponse:
            errorMessage =
            'Received invalid status code: ${err.response?.statusCode}';
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = 'Send timeout in connection';
            break;

          case DioExceptionType.badCertificate:
          
            errorMessage = 'Invalid certificate';
            break;
          case DioExceptionType.unknown:
            errorMessage = 'Unexpected error occured';
            break;
        }
        break;
      case SocketException:
        errorMessage = 'Connection error, check connection and try again ';
        break;
      case FormatException:
        errorMessage = 'Invalid format';
        break;
      default:
      // Handle other exceptions
        break;
    }
    return errorMessage;
  }
}