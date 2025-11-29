import 'package:cocktalez/app/cocktails/data/model/cocktail_response.dart';
import 'package:cocktalez/app/cocktails/provider/cocktail_provider.dart';
import 'package:cocktalez/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sized_context/sized_context.dart';

import '../../../../constants/router.dart';
import '../../../components/app_header.dart';
import '../../../components/app_image.dart';
import 'package:cocktalez/app/components/async_data_widget.dart';
import 'package:cocktalez/app/components/loading_indicator.dart';
import '../../../components/buttons.dart';

import '../../../components/cocktail_grid.dart';
part '../widgets/_result_tile.dart';

class CocktailsByIngridientPage extends StatelessWidget {
  final String ingridient;

  const CocktailsByIngridientPage({super.key, required this.ingridient});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return AsyncDataWidget<CocktailResponse>(
        provider: cocktailByIngridientProvider(ingridient),
        data: (cocktailResponse) {
          Widget content = GestureDetector(
            onTap: FocusManager.instance.primaryFocus?.unfocus,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeader(title: '', subtitle: '$ingridient cocktails'),
                Expanded(
                  child: RepaintBoundary(
                    child: _IngredientCocktailGrid(
                      items: cocktailResponse.drinks,
                      onPressed: (Drinks drink) {
                        context.push(ScreenPaths.cocktailDetails(drink.idDrink));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
          
          return Stack(
            children: [
              Positioned.fill(
                child: ColoredBox(
                  color: Theme.of(context).cardColor,
                  child: content,
                ),
              ),
            ],
          );
        },
        wrapLoadingInScaffold: true,
        wrapErrorInScaffold: true,
        loading: () => const AppLoadingIndicator(),
      );
    });
  }
}

class _IngredientCocktailGrid extends StatelessWidget {
  final List<Drinks> items;
  final void Function(Drinks) onPressed;

  const _IngredientCocktailGrid({required this.items, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CocktailGridWidget<Drinks>(
      items: items,
      itemBuilder: (context, drink) => _ResultTile(onPressed: onPressed, data: drink),
      crossAxisCount: (context.widthPx / 300).ceil(),
      childAspectRatio: 0.7,
      mainAxisSpacing: $dimensions.insets.sm,
      crossAxisSpacing: $dimensions.insets.sm,
      padding: EdgeInsets.all($dimensions.insets.sm).copyWith(bottom: $dimensions.insets.offset * 1.5),
    );
  }
}
