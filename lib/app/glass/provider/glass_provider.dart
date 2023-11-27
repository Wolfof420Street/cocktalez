import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';

import 'package:riverpod/riverpod.dart';

final glassesProvider = FutureProvider((ref) async {
  var glasses = await ref.watch(cocktailServiceProvider).getGlasses();

  return glasses;
});

final cocktailByGlassProvider = FutureProvider.family<CocktailResponse, String>(
  (ref, glass) async {
    var result = await ref.watch(cocktailServiceProvider).getCocktailsByGlass(glass);
    if (result.isSuccess) {
      return result.data;
    } else {
      throw Exception(result.error.errorMessage);
    }
  },
);
