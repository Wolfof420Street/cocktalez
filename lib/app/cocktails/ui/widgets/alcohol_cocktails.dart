// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/base_cocktail_class.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/cocktail_card_renderer.dart';
import 'package:cocktalez/app/cocktails/ui/widgets/rotation_3d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/cocktail_response.dart';

class AlcoholicCocktails extends StatefulWidget {
  const AlcoholicCocktails({super.key});

  @override
  State<AlcoholicCocktails> createState() => _AlcoholicCocktailsState();
}
class _AlcoholicCocktailsState extends BaseCocktailState<AlcoholicCocktails, CocktailResponse> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final alcoholicCocktailsState = ref.watch(alcoholicCocktailsProvider);

      return alcoholicCocktailsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (cocktails) {
          // Build the UI for displaying alcoholic cocktails
          return PageView.builder(
            controller: pageController,
            itemCount: cocktails.drinks.length,
            itemBuilder: (context, index) {
              final cocktail = cocktails.drinks[index];
              // Use Rotation3d, CocktailCardRenderer, etc., to render each cocktail card
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