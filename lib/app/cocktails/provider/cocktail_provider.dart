import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cocktalez/app/cocktails/data/provider/repository_provider.dart';
import 'package:cocktalez/app/ingredients/data/provider/repository_provider.dart';
import 'package:cocktalez/app/cocktails/data/model/category_response.dart';
import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';

final alcoholicCocktailsProvider = FutureProvider.autoDispose<CocktailResponse>((ref) async {
  return await ref.watch(cocktailRepositoryProvider).getAlcoholicCocktails();
});

final popularCocktailsProvider = FutureProvider.autoDispose<FullCocktailResponse>((ref) async {
  return await ref.watch(cocktailRepositoryProvider).getPopularCocktails();
});

final nonAlcoholicCocktailsProvider = FutureProvider.autoDispose<CocktailResponse>((ref) async {
  return await ref.watch(cocktailRepositoryProvider).getNonAlcoholicCocktails();
});

final categoriesProvider = FutureProvider.autoDispose<CategoryResponse>((ref) async {
  return await ref.watch(cocktailRepositoryProvider).getCategories();
});

final ingridientsProvider = FutureProvider.autoDispose<IngridientsResponse>((ref) async {
  return await ref.watch(ingredientRepositoryProvider).getIngredients();
});

final randomCocktailProvider = FutureProvider.autoDispose<FullCocktailResponse>((ref) async {
  return await ref.watch(cocktailRepositoryProvider).getRandomCocktail();
});

final cocktailDetailsProvider = FutureProvider.autoDispose.family<FullCocktailResponse, String>(
  (ref, id) async {
    return await ref.watch(cocktailRepositoryProvider).getCocktailDetails(id);
  },
);

final cocktailByCategoryProvider = FutureProvider.autoDispose.family<CocktailResponse, String>(
  (ref, category) async {
    return await ref.watch(cocktailRepositoryProvider).getCocktailsByCategory(category);
  },
);

final cocktailByIngridientProvider = FutureProvider.autoDispose.family<CocktailResponse, String>(
  (ref, ingridient) async {
    return await ref.watch(cocktailRepositoryProvider).getCocktailsByIngredient(ingridient);
  },
);
