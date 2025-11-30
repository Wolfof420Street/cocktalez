// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/cocktail_carousel.dart';
import '../../data/model/cocktail_response.dart';

class NonAlcoholicCocktails extends StatelessWidget {
  const NonAlcoholicCocktails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return CocktailCarousel<dynamic>(
          provider: nonAlcoholicCocktailsProvider,
          extractDrinks: (response) {
            if (response is CocktailResponse) {
              return response.drinks;
            }
            return [];
          },
          onRefresh: () => ref.refresh(nonAlcoholicCocktailsProvider),
        );
      },
    );
  }
}
