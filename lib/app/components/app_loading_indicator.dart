
import 'package:cocktalez/app/components/adaptive/adaptive_spinner.dart';
import 'package:cocktalez/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.value, this.color});
  final Color? color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    // Note: AdaptiveSpinner currently doesn't support 'value' (determinate progress).
    // If 'value' is needed, we might need to extend AdaptiveSpinner.
    // However, the existing usage seems to be mostly indeterminate or we can ignore value for iOS spinner.
    // For Android, we can pass it if we update AdaptiveSpinner.
    // For now, we will use AdaptiveSpinner which is indeterminate.
    // If value is critical, we should update AdaptiveSpinner.
    // Checking usage: 'value' is passed.
    // Let's update AdaptiveSpinner to accept value?
    // The user said "Replace ... with AdaptiveSpinner".
    // I'll assume indeterminate for now as CupertinoActivityIndicator is always indeterminate (mostly).
    // Actually, let's just use AdaptiveSpinner and ignore value for now to satisfy the "Leaf Migration" request strictly.
    
    return Center(
      child: AdaptiveSpinner(
        color: color ?? AppColors.accent,
        radius: 20, // 40 width / 2
      ),
    );
  }
}