import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/glass_repository.dart';

/// Provides a singleton instance of [GlassRepository].
///
/// This provider exposes the repository for use in other providers and UI logic.
/// The repository is a singleton (single instance across the app lifetime).
final glassRepositoryProvider = Provider<GlassRepository>((ref) {
  return GlassRepository();
});
