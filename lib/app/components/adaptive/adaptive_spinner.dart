import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'platform_provider.dart';

class AdaptiveSpinner extends ConsumerWidget {
  const AdaptiveSpinner({
    super.key,
    this.radius = 10.0,
    this.color,
  });

  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.watch(platformProvider);
    final isIos = platform == TargetPlatform.iOS;

    if (isIos) {
      return CupertinoActivityIndicator(
        radius: radius,
        color: color,
      );
    } else {
      return SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
        ),
      );
    }
  }
}
