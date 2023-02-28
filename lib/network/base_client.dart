import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../app/components/flat_button.dart';
import '../app/components/regular_text.dart';

class BaseClient {
  BaseClient();

  static Dio getClient(String baseUrl) {
    Dio dio = Dio();

    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    return dio;
  }

  static errorDialog(String errorMessage) {
    return showDialog(
        context: Get.context!,
        builder: (builder) {
          return AlertDialog(
            title: regularText('An error occurred',
                fontSize: 20.sp, fontWeight: FontWeight.w500),
            content: regularText(errorMessage,
                fontSize: 16.sp, textAlign: TextAlign.center),
            actions: [
              flatButton('Okay', () {
                Navigator.pop(Get.context!);
              })
            ],
          );
        });
  }
}
