import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/search_repository.dart';

/// Provides a singleton instance of [SearchRepository].
///
/// This provider exposes the repository for use in other providers and UI logic.
/// The repository is a singleton (single instance across the app lifetime).
final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository();
});
