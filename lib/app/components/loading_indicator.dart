import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Centralized loading indicator widget that uses a cached Lottie animation.
/// This prevents reloading the animation asset on every state change.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size,
    this.message,
  });

  final double? size;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size ?? 200,
            height: size ?? 200,
            child: Lottie.asset(
              'assets/anim/intro_loading.json',
              // Cache the composition to avoid reloading
              frameRate: FrameRate.max,
              // Repeat indefinitely
              repeat: true,
              // Use cached composition if available
              addRepaintBoundary: true,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

/// Scaffold wrapper for full-screen loading state
class AppLoadingScaffold extends StatelessWidget {
  const AppLoadingScaffold({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppLoadingIndicator(message: message),
    );
  }
}
