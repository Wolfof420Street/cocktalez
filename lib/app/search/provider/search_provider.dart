import 'package:cocktalez/app/cocktails/data/model/ingridients_response.dart';
import 'package:cocktalez/app/search/data/remote/search_service.dart';
import 'package:cocktalez/network/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchService = Provider<SearchService>((ref) {
  var dio = ref.read(networkProvider);
  return SearchService(dio);
});


final searchCocktailsProvider = FutureProvider.family<dynamic, String>(
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
