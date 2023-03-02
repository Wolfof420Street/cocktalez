import 'package:cocktalez/app/components/regular_text.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'flat_button.dart';

Widget customErrorWidget(VoidCallback onRefresh, {BuildContext? context}) {
  return Stack(
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: .5.sh,
            color: AppColors.error,
            child: const Center(
              child: Icon(
                Icons.warning_rounded,
                size: 150,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          regularText('Oh Snap!', fontSize: 24.sp, fontWeight: FontWeight.bold),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
            child: regularText(
                'Looks like something broke here. We\'ll work on fixing things so please try again later. ',
                fontSize: 16.sp,
                textAlign: TextAlign.center),
          ),
          const Spacer(),
          Container(
            height: 54.h,
            margin: const EdgeInsets.all(15),
            child: flatButton('Retry', () {
              onRefresh();
            }),
          )
        ],
      ),
      Positioned(
        top: kToolbarHeight,
        right: 20.w,
        child: InkWell(
          onTap: () => Navigator.pop(context!),
          child: const Icon(
            Icons.close,
            color: AppColors.primary,
          ),
        ),
      ),
    ],
  );
}