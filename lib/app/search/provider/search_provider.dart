import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';
import 'package:cocktalez/app/search/data/remote/search_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchCocktailsProvider = FutureProvider.family<FullCocktailResponse, String>(
  (ref, arg) async {
    final search = await ref.watch(searchService).searchCocktails(arg);
    return search;
  }
);

final searchIngredientProvider = FutureProvider.family<IngridientsResponse, String>(
  (ref, arg) async {
    final search = await ref.watch(searchService).searchIngridient(arg);
    return search;
  }
);
