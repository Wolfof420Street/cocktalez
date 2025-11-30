import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'platform_provider.dart';

class AdaptiveAppBar extends ConsumerWidget implements PreferredSizeWidget, ObstructingPreferredSizeWidget {
  const AdaptiveAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.centerTitle,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.watch(platformProvider);
    final isIos = platform == TargetPlatform.iOS;

    if (isIos) {
      Widget? trailing;
      if (actions != null && actions!.isNotEmpty) {
        trailing = actions!.length == 1
            ? actions!.first
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: actions!,
              );
      }

      return CupertinoNavigationBar(
        middle: title,
        leading: leading,
        trailing: trailing,
        backgroundColor: backgroundColor,
        // CupertinoNavigationBar automatically handles safe area and blur
      );
    } else {
      return AppBar(
        title: title,
        leading: leading,
        actions: actions,
        backgroundColor: backgroundColor,
        centerTitle: centerTitle,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    // For simplicity, assuming opaque or standard blur behavior.
    // In a real app, we might check backgroundColor alpha.
    return backgroundColor != null && backgroundColor!.a == 1.0;
  }
}
