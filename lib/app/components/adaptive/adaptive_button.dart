import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'platform_provider.dart';

class AdaptiveButton extends ConsumerWidget {
  const AdaptiveButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.padding,
    this.borderRadius,
    this.border,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final BorderSide? border;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.watch(platformProvider);
    final isIos = platform == TargetPlatform.iOS;

    if (isIos) {
      // CupertinoButton doesn't have a border property directly.
      // We wrap it in a Container or DecoratedBox if a border is needed,
      // but CupertinoButton is usually borderless or filled.
      // If border is present, we might need a custom layout.
      // However, for simplicity and "Native" feel, standard CupertinoButtons don't usually have borders unless outlined.
      // If we want to support it, we can wrap the child or the button.
      // Better approach: Use Container with decoration around the button? No, button has internal padding.
      // Let's wrap the button in a DecoratedBox if border exists, but that might mess up tap area.
      // Alternative: Use `CupertinoButton.filled` logic but with custom decoration?
      // Actually, let's just ignore border for iOS standard buttons unless critical, OR apply it to the container.
      // Given AppBtn usage, it might be important.
      // Let's use a Container with BoxDecoration for the border, and put the button inside?
      // But CupertinoButton has a background color.
      
      // Let's try to match the intent.
      return CupertinoButton(
        onPressed: onPressed,
        color: color,
        padding: padding,
        borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
        // If border is provided, we can't easily apply it to CupertinoButton directly without custom painting.
        // For now, we will omit border on iOS to keep it "Native" unless strictly required.
        // Wait, the user wants "Visual Parity".
        // If I can't do it easily, I'll skip it for now or use a Container wrapper.
        // Let's leave it as is for iOS (no border support) and document it, OR implement a wrapper.
        // Wrapper approach:
        child: border != null
            ? Container(
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(border!),
                  borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: child,
              )
            : child,
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.zero,
            side: border ?? BorderSide.none,
          ),
          elevation: 0, // Flatten for parity with TextButton/AppBtn
        ),
        child: child,
      );
    }
  }
}
