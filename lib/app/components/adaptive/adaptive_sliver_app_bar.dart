import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'platform_provider.dart';

class AdaptiveSliverAppBar extends ConsumerWidget {
  const AdaptiveSliverAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.expandedHeight,
    this.collapsedHeight,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.stretch = false,
    this.backgroundColor,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final double? expandedHeight;
  final double? collapsedHeight;
  final bool pinned;
  final bool floating;
  final bool snap;
  final bool stretch;
  final Color? backgroundColor;

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

      return CupertinoSliverNavigationBar(
        largeTitle: title, // Use large title for sliver behavior
        leading: leading,
        trailing: trailing,
        backgroundColor: backgroundColor,
        border: null, // Remove border to blend if needed
        stretch: stretch,
        // Note: CupertinoSliverNavigationBar doesn't support flexibleSpace/expandedHeight 
        // in the same way as Material. The large title expands. 
        // If flexibleSpace was intended for an image, it should be placed in the body 
        // as a SliverToBoxAdapter on iOS.
      );
    } else {
      return SliverAppBar(
        title: title,
        leading: leading,
        actions: actions,
        flexibleSpace: flexibleSpace,
        expandedHeight: expandedHeight,
        collapsedHeight: collapsedHeight,
        pinned: pinned,
        floating: floating,
        snap: snap,
        stretch: stretch,
        backgroundColor: backgroundColor,
        elevation: 0,
      );
    }
  }
}
