import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/cocktail_carousel.dart';

class PopularCocktails extends StatelessWidget {
  const PopularCocktails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return CocktailCarousel<dynamic>(
          provider: popularCocktailsProvider,
          extractDrinks: (response) {
            if (response is FullCocktailResponse) {
              return response.drinks;
            }
            return [];
          },
          onRefresh: () => ref.refresh(popularCocktailsProvider),
        );
      },
    );
  }
}
