import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/base_cocktail_class.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/cocktail_card_renderer.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/rotation_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PopularCocktails extends StatefulWidget {
  const PopularCocktails({super.key});

  @override
  State<PopularCocktails> createState() => _PopularCocktailsState();
}

class _PopularCocktailsState
    extends BaseCocktailState<PopularCocktails, FullCocktailResponse> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final popularCocktailsState = ref.watch(popularCocktailsProvider);

      return popularCocktailsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (cocktails) {
          // Build the UI for displaying popular cocktails
          return PageView.builder(
            controller: pageController,
            itemCount: cocktails.drinks.length,
            itemBuilder: (context, index) {
              final cocktail = cocktails.drinks[index];
            
              return Rotation3d(
                rotationY: normalizedOffset * maxRotation,
                child: CocktailCardRenderer(
                  normalizedOffset,
                  cocktail: cocktail,
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
                ),
              );
            },
          );
        },
      );
    });
  }

  
}
