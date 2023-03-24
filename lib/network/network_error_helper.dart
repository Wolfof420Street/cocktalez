import 'dart:io';

import 'package:dio/dio.dart';

class NetworkErrorHandler {
  static String handleError(DioError err) {
    String errorMessage = '';

    switch (err.runtimeType) {
      case DioError:
        switch (err.type) {
          case DioErrorType.cancel:
            errorMessage = 'Request was cancelled';
            break;
          case DioErrorType.connectTimeout:
            errorMessage = 'Connection timeout';
            break;
          case DioErrorType.other:
            errorMessage = 'Something went wrong';
            break;
          case DioErrorType.receiveTimeout:
            errorMessage = 'Receive timeout in connection';
            break;
          case DioErrorType.response:
            errorMessage =
            'Received invalid status code: ${err.response?.statusCode}';
            break;
          case DioErrorType.sendTimeout:
            errorMessage = 'Send timeout in connection';
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