import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/cocktail_repository.dart';

/// Global repository provider for cocktails.
///
/// This makes the repository injectable and swappable for tests.
final cocktailRepositoryProvider = Provider<CocktailRepository>((ref) {
  return CocktailRepository();
});
