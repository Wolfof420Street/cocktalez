import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/remote/cocktail_service.dart';
import 'package:cocktalez/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cocktailServiceProvider = Provider<CocktailService>((ref) {
  var dio = ref.read(networkProvider);
  return CocktailService(dio);
});
final alcoholicCocktailsProvider = FutureProvider((ref) async {
  var result = await ref.watch(cocktailServiceProvider).getAlcoholicCocktails();
  if (result.isSuccess) {
    return result.data;
  } else {
    throw Exception(result.error.errorMessage);
  }
});

final popularCocktailsProvider = FutureProvider((ref) async {
  var result = await ref.watch(cocktailServiceProvider).getPopularCocktails();
  if (result.isSuccess) {
    return result.data;
  } else {
    throw Exception(result.error.errorMessage);
  }
});

final nonAlcoholicCocktailsProvider = FutureProvider((ref) async {
  var result =
      await ref.watch(cocktailServiceProvider).getNonAlcoholicCocktails();
  if (result.isSuccess) {
    return result.data;
  } else {
    throw Exception(result.error.errorMessage);
  }
});

final categoriesProvider = FutureProvider((ref) async {
  var result = await ref.watch(cocktailServiceProvider).getCategories();
  if (result.isSuccess) {
    return result.data;
  } else {
    throw Exception(result.error.errorMessage);
  }
});

final ingredientsProvider = FutureProvider((ref) async {
  var result = await ref.watch(cocktailServiceProvider).getIngridients();
  if (result.isSuccess) {
    return result.data;
  } else {
    throw Exception(result.error.errorMessage);
  }
});

final randomCocktailProvider = FutureProvider((ref) async {
  var result = await ref.watch(cocktailServiceProvider).getRandomCocktail();
  if (result.isSuccess) {
    return result.data;
  } else {
    throw Exception(result.error.errorMessage);
  }
});

final cocktailDetailsProvider =
    FutureProvider.family<FullCocktailResponse, String>(
  (ref, id) async {
    var result =
        await ref.watch(cocktailServiceProvider).getCocktailDetails(id);
    if (result.isSuccess) {
      return result.data;
    } else {
      // Handle failure case, e.g., throw an exception or return a default value
      throw Exception(result.error.errorMessage);
    }
  },
);

final cocktailByCategoryProvider =
    FutureProvider.family<CocktailResponse, String>(
  (ref, category) async {
    var result = await ref
        .watch(cocktailServiceProvider)
        .getCocktailsByCategory(category);
    if (result.isSuccess) {
      return result.data;
    } else {
      // Handle failure case, e.g., throw an exception or return a default value
      throw Exception(result.error.errorMessage);
    }
  },
);

final cocktailByIngredientProvider =
    FutureProvider.family<CocktailResponse, String>(
  (ref, ingredient) async {
    var result = await ref
        .watch(cocktailServiceProvider)
        .getCocktailsByIngredient(ingredient);
    if (result.isSuccess) {
      return result.data;
    } else {
      // Handle failure case, e.g., throw an exception or return a default value
      throw Exception(result.error.errorMessage);
    }
  },
);
