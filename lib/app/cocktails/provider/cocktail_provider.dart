import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/remote/cocktail_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alcoholicCocktailsProvider = FutureProvider((ref) async {
  var alcohols =
      await ref.watch(cocktailServiceProvider).getAlcoholicCocktails();

  return alcohols;
});

final popularCocktailsProvider = FutureProvider((ref) async {
  var alcohols = await ref.watch(cocktailServiceProvider).getPopularCocktails();

  return alcohols;
});

final nonAlcoholicCocktailsProvider = FutureProvider((ref) async {
  var alcohols =
      await ref.watch(cocktailServiceProvider).getNonAlcoholicCocktails();

  return alcohols;
});

final categoriesProvider = FutureProvider((ref) async {
  var categories = await ref.watch(cocktailServiceProvider).getCategories();

  return categories;
});



final ingridientsProvider = FutureProvider((ref) async {
  var ingridients = await ref.watch(cocktailServiceProvider).getIngridients();

  return ingridients;
});

final randomCocktailProvider = FutureProvider((ref) async {
  var randomCocktail =
      await ref.watch(cocktailServiceProvider).getRandomCocktail();

  return randomCocktail;
});

final cocktailDetailsProvider =
    FutureProvider.family<FullCocktailResponse, String>(
  (ref, id) async {
    final cocktailDetails =
        await ref.watch(cocktailServiceProvider).getCocktailDetails(id);

    return cocktailDetails;
  },
);



final cocktailByCategoryProvider =
    FutureProvider.family<CocktailResponse, String>(
  (ref, category) async {
    final cocktailsByCategory = await ref
        .watch(cocktailServiceProvider)
        .getCocktailsByCategory(category);

    return cocktailsByCategory;
  },
);

final cocktailByIngridientProvider =
    FutureProvider.family<CocktailResponse, String>(
  (ref, ingridient) async {
    final cocktailsByIngridient = await ref
        .watch(cocktailServiceProvider)
        .getCocktailsByIngredient(ingridient);

    return cocktailsByIngridient;
  },
);
