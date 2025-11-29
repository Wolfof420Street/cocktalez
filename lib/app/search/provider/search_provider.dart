import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/search/data/provider/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchCocktailsProvider = FutureProvider.autoDispose.family<FullCocktailResponse, String>(
  (ref, query) async {
    return await ref.watch(searchRepositoryProvider).searchCocktails(query);
  },
);

final searchIngredientProvider = FutureProvider.autoDispose.family<FullCocktailResponse, String>(
  (ref, ingredient) async {
    return await ref.watch(searchRepositoryProvider).searchIngredient(ingredient);
  },
);
