
import 'package:cocktalez/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



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
          Text('Oh Snap!', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 10.h),
            child: Text(
                'Looks like something broke here. We\'ll work on fixing things so please try again later. ',
                 textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp,
               ),),
          ),
          Container(
            height: 54.h,
            margin: const EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () { 
                 onRefresh();
               },
              child: Text('Retry', style: Theme.of(context!).textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
            ),
          )
        ],
      ),
      Positioned(
        top: kToolbarHeight,
        right: 20.w,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: AppColors.primary,
          ),
        ),
      ),
    ],
  );
}