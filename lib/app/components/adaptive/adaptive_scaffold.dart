import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'platform_provider.dart';

class AdaptiveScaffold extends ConsumerWidget {
  const AdaptiveScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  /// The app bar to display.
  ///
  /// On iOS, this should ideally be an [AdaptiveAppBar] or a widget implementing [ObstructingPreferredSizeWidget].
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.watch(platformProvider);
    final isIos = platform == TargetPlatform.iOS;
    
    // Use the theme's scaffold background color if not provided
    final effectiveBackgroundColor = backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;

    if (isIos) {
      return CupertinoPageScaffold(
        navigationBar: appBar as ObstructingPreferredSizeWidget?,
        backgroundColor: effectiveBackgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        child: SafeArea(
          top: appBar == null, // If app bar exists, it handles top padding (usually)
          bottom: false, // Usually handled by bottom nav or content
          child: body,
        ),
      );
    } else {
      return Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: effectiveBackgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      );
    }
  }
}
