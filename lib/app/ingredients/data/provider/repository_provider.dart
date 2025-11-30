import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/ingredient_repository.dart';

/// Provides a singleton instance of [IngredientRepository].
///
/// This provider exposes the repository for use in other providers and UI logic.
/// The repository is a singleton (single instance across the app lifetime).
final ingredientRepositoryProvider = Provider<IngredientRepository>((ref) {
  return IngredientRepository();
});
