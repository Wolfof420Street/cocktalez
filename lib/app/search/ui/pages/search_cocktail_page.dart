import 'package:cocktalez/app/cocktails/data/model/cocktail_full_response.dart';
import 'package:cocktalez/app/search/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sized_context/sized_context.dart';

import '../../../../constants/router.dart';
import '../../../../main.dart';
import '../../../cocktails/data/model/cocktail_response.dart';
import '../../../components/app_header.dart';
import '../../../components/app_image.dart';
import 'package:cocktalez/app/components/async_data_widget.dart';
import '../../../components/buttons.dart';
import '../../../components/loading_indicator.dart';
import '../../../components/scroll_decorator.dart';

part '../widgets/_search_tile.dart';
part '../widgets/_search_cocktail_grid.dart';

class CocktailSearchScreen extends StatelessWidget {
  final String searchQuery;

  const CocktailSearchScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return AsyncMapWidget<dynamic, FullCocktailResponse>(
        provider: searchCocktailsProvider(searchQuery),
        extract: (data) {
          if (data is! FullCocktailResponse) return null;
          return data;
        },
        data: (searchCocktailsResponse) {
          if (searchCocktailsResponse.drinks.isEmpty) {
            return const Center(
              child: Text('No Cocktail Found with this name'),
            );
          }
          
          return SearchCocktailsResult(
            searchCocktailsResponse: searchCocktailsResponse,
            onPressed: (drink) =>
                context.push(ScreenPaths.cocktailDetails(drink.idDrink)),
          );
        },
        loading: () => const AppLoadingIndicator(),
      );
    });
  }
}

class SearchCocktailsResult extends StatelessWidget {
  final FullCocktailResponse searchCocktailsResponse;
  final void Function(Drinks drink) onPressed;

  const SearchCocktailsResult({
    super.key,
    required this.searchCocktailsResponse,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: SizedBox(
        height: context.heightPx,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppHeader(
              isTransparent: true,
              showBackBtn: false,
              title: '',
              subtitle: 'Search results',
            ),
            searchCocktailsResponse.drinks.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'No cocktails found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  )
                : Expanded(
                    child: RepaintBoundary(
                      child: SearchCocktailGrid(
                        cocktailResponse: searchCocktailsResponse,
                        onPressed: onPressed,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
