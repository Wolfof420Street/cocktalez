import 'dart:ui';

import 'package:cocktalez/app/components/regular_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors.dart';



Widget flatButton(String label, VoidCallback onPressed,
    {bool? keyBoardVisible, double? buttonHeight}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: buttonHeight ?? 54,
      width: 1.sw,
      padding: EdgeInsets.symmetric(
          horizontal: keyBoardVisible ?? false ? 0 : 20),
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(keyBoardVisible ?? false ? 0 : 7)),
      child: Center(child: regularText(label, color: Colors.white)),
    ),
  );
}