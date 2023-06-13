import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/remote/cocktail_service.dart';
import 'package:riverpod/riverpod.dart';

final glassesProvider = FutureProvider((ref) async {
  var glasses = await ref.watch(cocktailServiceProvider).getGlasses();

  return glasses;
});

final cocktailByGlassProvider = FutureProvider.family<CocktailResponse, String>(
  (ref, glass) async {
    final cocktailsByGlass =
        await ref.watch(cocktailServiceProvider).getCocktailsByGlass(glass);

    return cocktailsByGlass;
  },
);