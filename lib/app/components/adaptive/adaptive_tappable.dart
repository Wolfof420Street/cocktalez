
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'platform_provider.dart';

/// A platform-adaptive widget that handles tap interactions.
///
/// On **iOS** (Cupertino), it uses a [GestureDetector] with a fade opacity effect
/// to simulate the native "tap" feel.
///
/// On **Android** (Material), it uses an [InkWell] to provide the standard ripple effect.
class AdaptiveTappable extends ConsumerWidget {
  const AdaptiveTappable({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius,
    this.hitTestBehavior = HitTestBehavior.opaque,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final HitTestBehavior hitTestBehavior;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platform = ref.watch(platformProvider);
    final isIos = platform == TargetPlatform.iOS;

    if (isIos) {
      return _CupertinoTap(
        onTap: onTap,
        behavior: hitTestBehavior,
        child: child,
      );
    } else {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: child,
      );
    }
  }
}

class _CupertinoTap extends StatefulWidget {
  const _CupertinoTap({
    required this.child,
    required this.onTap,
    this.behavior = HitTestBehavior.opaque,
  });

  final Widget child;
  final VoidCallback? onTap;
  final HitTestBehavior behavior;

  @override
  State<_CupertinoTap> createState() => _CupertinoTapState();
}

class _CupertinoTapState extends State<_CupertinoTap> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  bool _isDown = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_isDown) {
      _isDown = true;
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isDown) {
      _isDown = false;
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (_isDown) {
      _isDown = false;
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onTap,
      onTapDown: widget.onTap != null ? _handleTapDown : null,
      onTapUp: widget.onTap != null ? _handleTapUp : null,
      onTapCancel: widget.onTap != null ? _handleTapCancel : null,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child,
      ),
    );
  }
}
