import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/data/provider/repository_provider.dart';
import 'package:cocktalez/app/glass/data/provider/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final glassesProvider = FutureProvider.autoDispose((ref) async {
  return await ref.watch(glassRepositoryProvider).getGlasses();
});

final cocktailByGlassProvider = FutureProvider.autoDispose.family<CocktailResponse, String>(
  (ref, glass) async {
    return await ref.watch(cocktailRepositoryProvider).getCocktailsByGlass(glass);
  },
);