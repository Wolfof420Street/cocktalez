import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider that returns the current [TargetPlatform].
///
/// This provider can be overridden in tests or for debugging purposes
/// to simulate a different platform (e.g., forcing iOS on an Android device).
///
/// Usage:
/// ```dart
/// final platform = ref.watch(platformProvider);
/// if (platform == TargetPlatform.iOS) { ... }
/// ```
final platformProvider = Provider<TargetPlatform>((ref) {
  return defaultTargetPlatform;
});
