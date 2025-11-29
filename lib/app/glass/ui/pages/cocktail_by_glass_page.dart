import 'package:cocktalez/app/components/buttons.dart';
import 'package:cocktalez/app/glass/provider/glass_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sized_context/sized_context.dart';

import '../../../../constants/router.dart';
import '../../../../main.dart';
import '../../../cocktails/data/model/cocktail_response.dart';
import '../../../components/app_header.dart';
import '../../../components/app_image.dart';
import 'package:cocktalez/app/components/async_data_widget.dart';


import '../../../components/cocktail_grid.dart';
part '../widgets/_glass_tile.dart';

class CocktailByGlassPage extends StatelessWidget {
  final String glass;

  const CocktailByGlassPage({super.key, required this.glass});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return AsyncDataWidget<CocktailResponse>(
        provider: cocktailByGlassProvider(glass),
        data: (cocktailResponse) {
          Widget content = GestureDetector(
            onTap: FocusManager.instance.primaryFocus?.unfocus,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppHeader(title: '', subtitle: '$glass cocktails'),
                Expanded(
                  child: RepaintBoundary(
                    child: _GlassCocktailGrid(
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
      );
    });
  }
}

class _GlassCocktailGrid extends StatelessWidget {
  final List<Drinks> items;
  final void Function(Drinks) onPressed;

  const _GlassCocktailGrid({required this.items, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CocktailGridWidget<Drinks>(
      items: items,
      itemBuilder: (context, drink) => _GlassTile(onPressed: onPressed, data: drink),
      crossAxisCount: (context.widthPx / 300).ceil(),
      childAspectRatio: 0.7,
      mainAxisSpacing: $dimensions.insets.sm,
      crossAxisSpacing: $dimensions.insets.sm,
      padding: EdgeInsets.all($dimensions.insets.sm).copyWith(bottom: $dimensions.insets.offset * 1.5),
    );
  }
}
