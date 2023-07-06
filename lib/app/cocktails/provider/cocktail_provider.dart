import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/remote/cocktail_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final alcoholicCocktailsProvider = FutureProvider((ref) async {
  return
      await ref.watch(cocktailServiceProvider).getAlcoholicCocktails();

 
});

final popularCocktailsProvider = FutureProvider((ref) async {
 return await ref.watch(cocktailServiceProvider).getPopularCocktails();

 
});

final nonAlcoholicCocktailsProvider = FutureProvider((ref) async {
  return ref.watch(cocktailServiceProvider).getNonAlcoholicCocktails();


});

final categoriesProvider = FutureProvider((ref) async {
  return await ref.watch(cocktailServiceProvider).getCategories();

 
});



final ingridientsProvider = FutureProvider((ref) async {
  return await ref.watch(cocktailServiceProvider).getIngridients();

});

final randomCocktailProvider = FutureProvider((ref) async {
  return
      await ref.watch(cocktailServiceProvider).getRandomCocktail();


});

final cocktailDetailsProvider =
    FutureProvider.family<FullCocktailResponse, String>(
  (ref, id) async {

    return 
        await ref.watch(cocktailServiceProvider).getCocktailDetails(id);
        
  },
);



final cocktailByCategoryProvider =
    FutureProvider.family<CocktailResponse, String>(
  (ref, category) async {
    return await ref
        .watch(cocktailServiceProvider)
        .getCocktailsByCategory(category);

   
  },
);

final cocktailByIngridientProvider =
    FutureProvider.family<CocktailResponse, String>(
  (ref, ingridient) async {
    return await ref
        .watch(cocktailServiceProvider)
        .getCocktailsByIngredient(ingridient);
  },
);
